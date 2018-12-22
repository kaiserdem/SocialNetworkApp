//
//  ViewController.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 19.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var singInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var titelLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(_vc: self)
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)// приячим навигейшен бар
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // функция добавляет тргет к кнопкам
    private func addTargets() {
        singInButton.addTarget(self, action: #selector(singInButtonCliced), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonCliced), for: .touchUpInside)

        
    }
    @objc private func singInButtonCliced() {
        
    }
    @objc private func registerButtonCliced() {
        StartRouter.shared.goToRegisterScreen(from: self)
    }

}

extension ViewController {// расшинеие сласса
    fileprivate class Decorator { // приватный класс
        static let buttonCornerRadius: CGFloat = 8
        private init() {}

        static func decorate(_vc: ViewController) {
            _vc.registerButton.layer.cornerRadius = buttonCornerRadius
            _vc.registerButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        }
    }
}
