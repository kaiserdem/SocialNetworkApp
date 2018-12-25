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
    static let shared = AuthManeger()
    private init() {}
    
    // указывает на первоначальную ветку в базе данных
    private var sourseRef:DatabaseReference {
      return Database.database().reference()
    }
    private let auth = Auth.auth()

    func register(with model: RegisterModel, completion: VoidClosure) { // загружает модель данных
        // создаем модель нового пользователя ветки пользователя
        guard model.isFilled else { // с условием не пустых полей
            return
        }
        guard let email = model.email, let password = model.password else {
            return
        }
        let userRef = sourseRef.child("users")
        let id = ID()
        auth.createUser(withEmail: email, password: password) { (result, error) in
            userRef.child(id)
        }
    }
}
