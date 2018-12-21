//
//  StartRouter.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class StartRouter {
    static let shared = StartRouter()
    
    private init() {} // закрываем возможность инициализироваться
    
    func goToRegisterScreen(from source: UIViewController) {
        let vc = RegisterViewController()
        print("RegisterViewController")
        source.navigationController?.pushViewController(vc, animated: true)
    }
}
