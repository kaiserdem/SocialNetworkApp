//
//  Router.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 19.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class Router {
    // переменная через которую полуать доступ
    static let shared = Router()
    
    private init() {} 
    
    //константа для того что б выносить вю контроллер
    private let rootViewController: UIViewController = ViewController()
    
    func root(_ window: inout UIWindow?) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    }
}
