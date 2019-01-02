//
//  SecureStorageManager.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 31.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation
import Locksmith

final class SecureStorageManager { // менеджер безопасного хранения
    static let shared = SecureStorageManager()
    
    let myUserAccountIdentifier = "MyUserAccountIdentifier"
    
    private init() {}
    // сохраняем данные
    func save(email: String?, password: String?, completionHandler: ItemClosure<CustomErrors?>) {
        guard let email = email, let password = password else { // если существует
            completionHandler(CustomErrors.keychainError)
            return
        }
        let data = [Keys.email.rawValue: email,
                    Keys.password.rawValue: password]
        do {
            try Locksmith.saveData(data: data, forUserAccount: myUserAccountIdentifier)
            completionHandler(nil) //сохраняем дату
        }
        catch {
            completionHandler(CustomErrors.keychainError)
        }
    }
    func eraseUserDataIfNeded() {
        guard isLoggedIn() else {// если залогинен
            return
        }
        try? Locksmith.deleteDataForUserAccount(userAccount: myUserAccountIdentifier)
    }
    
    func eraseUserDataIfNeeded() {
        guard isLoggedIn() else {
            return
        }
        
        try? Locksmith.deleteDataForUserAccount(userAccount: myUserAccountIdentifier)
    }
    
    func loadEmailAndPassword() -> (email: String?, password: String?) {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: myUserAccountIdentifier)
        let email = dictionary?[Keys.email.rawValue] as? String ?? nil
        let password = dictionary?[Keys.password.rawValue] as? String ?? nil
        return (email: email, password: password)
    }
    
    func isLoggedIn() -> Bool { // проходил ли пользователь регистрацию
        let credentials = loadEmailAndPassword()
        return credentials.email != nil && credentials.password != nil
    }
}

private extension SecureStorageManager {
    enum Keys: String {
        case email
        case password
    }
}
