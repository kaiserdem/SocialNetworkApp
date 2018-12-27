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

class AuthManeger {
    var currentUser: User?   // текущий пользователь
    static let shared = AuthManeger()
    private init() {}
    
    // указывает на первоначальную ветку в базе данных
    private var sourseRef:DatabaseReference {
      return Database.database().reference()
    }
    private var userRef: DatabaseReference {
        return sourseRef.child("users")
    }
    
    private let auth = Auth.auth()

    // функция для автозации, возвр кожер с результатом
    func  singIn(with email: String, and password: String, completion:@escaping  ItemClosure<AuthResult>) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(AuthResult.error(error.localizedDescription))
                return
            }
            guard let user = result?.user else { // проверка пользователя
                completion(AuthResult.error("User not exist"))
                return
            }
            self.currentUser = user
            completion(AuthResult.success)
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
            } else if let _ = result {
                var dict = model.dict
                dict["id"] = id
                self.userRef.child(id).setValue(dict, withCompletionBlock: { (error, reference) in
                    self.addAvatarUrlNeeded(for: model)
                    completion(.success(()))
                })
            } else {
                completion(.failure(CustomErrors.unknownError))
            }
        }
    }
                  // добавляем ссылку на фото в бд
    func addAvatarUrlNeeded(for model: RegisterModel) {
        
        StorageManager.shared.loadAvatarUrl(for: model) { (url) in // загружаем url
            guard let url = url else { // проверяем на нил
                return
            } // нашли юзера по child, создаем новую ветку, записываем в базу
            self.userRef.child(model.userId).child("avatarUrl").setValue(url.absoluteString)
        }
    }
}
