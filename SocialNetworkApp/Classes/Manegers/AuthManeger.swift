//
//  AuthManeger.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 25.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit
import Firebase


class AuthManeger {
    static let shared = AuthManeger()
    private init() {}
    
    func register(with model: RegisterModel) {
        guard model.isFilled else {
            return
        }
    }
}
