//
//  StartRouter.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class StartRouter { // вызывает контроллер
    static let shared = StartRouter()
    
    private init() {} // закрываем возможность инициализироваться
    
    func goToRegisterScreen(from source: UIViewController) { // показывает контроллер
        let vc = RegisterViewController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
    func goToLoginScreen(from source: UIViewController){
        let vc = LoginViewController()
        source.navigationController?.pushViewController(vc, animated: true)

    }
}
