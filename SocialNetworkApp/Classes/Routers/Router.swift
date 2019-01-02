//
//  Router.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 19.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit //импорт

final class Router {
    // переменная через которую полуать доступ
    static let shared = Router()
    
    private init() {} // нет возможности создавать другие екземпляры, это синглтон
    
    func root(_ window: inout UIWindow?) { // функция принимает окно
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
        
        // если залогинен тогда startCont в противном случае стартовый
        let vc = SecureStorageManager.shared.isLoggedIn() ? startControllerAfterAuth : ViewController()
            // добавили нав контроллер
        window?.rootViewController = UINavigationController(rootViewController: vc)
    }
    var startControllerAfterAuth: UIViewController { // отдает краны появления другим классам
        let createVC = CreatePostViewController()
        let createPostNC = UINavigationController(rootViewController: createVC) // первый контроллер
        let createPostTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        createPostNC.tabBarItem = createPostTabBarItem
        
        let feedVC = FeadViewController() // второй контроллер
        let feedNC = UINavigationController(rootViewController: feedVC)
        let feedTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        feedNC.tabBarItem = feedTabBarItem
        
        let tabBarVC = UITabBarController()// в таб бар помещаем контроллеры
        // масив контроллеров
        tabBarVC.setViewControllers([feedNC, createPostNC], animated: true)
        return tabBarVC
    }
}

