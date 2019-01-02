//
//  StartRouter.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class StartRouter { // вызывает контроллер и перемещает между стартовыми котнроллерами
    static let shared = StartRouter()
    
    private init() {} // закрываем возможность инициализироваться
    
    func goToRegisterScreen(from source: UIViewController) { // показывает контроллер
        let vc = RegisterViewController()   // какой контроллер нужно вызвать
        source.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToLoginScreen(from source: UIViewController){
        let vc = LoginViewController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
    //перебросить на екран пост регистрацию и авторизацию
    func routerAfterSuccessAuth(from sourse: UIViewController) {
        let vc = Router.shared.startControllerAfterAuth
        sourse.present(vc, animated: true, completion: nil)
    }
}
