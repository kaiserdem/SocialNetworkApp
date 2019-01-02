//
//  AuthManeger.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 25.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import Locksmith

class AuthManeger: FirebaseMamager {
    
    var currentUser: User?   // текущий пользователь
    static let shared = AuthManeger() // получаем доступ

    private let auth = Auth.auth()
    
    func singInIfNeeded(completion: ItemClosure<FirebaseResult>? = nil) {
        // проверка сохранен ли пользователь
        let credentials = SecureStorageManager.shared.loadEmailAndPassword()
        
        guard let email = credentials.email, let password = credentials.password else {
            return
        }
        signIn(with: email, and: password, completion: completion ?? {_ in})
    }
    // функция для автозации, возвр кожер с результатом
    func signIn(with email: String?, and password: String?, completion: @escaping ItemClosure<FirebaseResult>) {
        guard let email = email, let password = password else {
            completion(FirebaseResult.error("Something wrong with email or password. Please try again"))
            return
        }
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(FirebaseResult.error(error.localizedDescription))
                return
            }
            
            guard let user = result?.user else {
                completion(FirebaseResult.error("User not exist"))
                return
            }
            
            self.currentUser = user
            completion(FirebaseResult.success)
        }
    }
    
           // загружает модель данных
    func register(with model: RegisterModel, completion: @escaping ResultHandler<Void>) {
        // создаем модель нового пользователя ветки пользователя
        guard model.isFilled else { // с условием не пустых полей
            completion(.failure(CustomErrors.unknownError))
            return
        }
        guard let email = model.email, let password = model.password else {
            completion(.failure(CustomErrors.unknownError))
            return
        }
        /// eazy validation for @ and dot localy. other ones are on the server
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(CustomErrors.invalidEmail))
            return
        }

        
        let id = model.userId
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let res = result else {
                completion(.failure(CustomErrors.unknownError))
                return
            }
            self.currentUser = res.user
            var dict = model.dict
            dict["id"] = id
            self.userRef.child(res.user.uid).setValue(dict, withCompletionBlock: { (error, reference) in
                self.addAvatarUrlNeeded(for: model, user: res.user)
                completion(.success(()))
            })
        }
    }
                  // добавляем ссылку на фото в бд
    func addAvatarUrlNeeded(for model: RegisterModel, user: User) {
        
        StorageManager.shared.loadAvatarUrl(for: model) { (url) in // загружаем url
            guard let url = url else { // проверяем на нил
                return
            } // нашли юзера по child, создаем новую ветку, записываем в базу
            self.userRef.child(user.uid).child("avatarUrl").setValue(url.absoluteString)
        }
    }
}
