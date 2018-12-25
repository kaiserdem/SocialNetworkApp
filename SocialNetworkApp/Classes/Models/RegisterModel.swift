//
//  RegisterModel.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 25.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit // хранения данных регистрации пользователя

class RegisterModel {
    var photo: UIImage?
    var email: String?
    var password: String?
    var sex: Sex = .male
    var birthday: Date?
    
    var isFilled: Bool { // заполнены все поля
        guard !(email ?? "").isEmpty, !(password ?? "").isEmpty, birthday != nil else {
            return false
        }
        return true
    }
}
