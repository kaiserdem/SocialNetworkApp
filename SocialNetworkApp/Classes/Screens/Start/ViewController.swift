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
        
    }
    // функция добавляет тргет к кнопкам
    private func addTargets() {
        singInButton.addTarget(self, action: #selector(singInButtonCliced), for: .touchUpInside)
        singInButton.addTarget(self, action: #selector(registerButtonCliced), for: .touchUpInside)

        
    }
    @objc private func singInButtonCliced() {
        
    }
    @objc private func registerButtonCliced() {
        
    }

}

extension ViewController {// расшинеие сласса
    fileprivate class Decorator { // приватный класс
        static let buttonCornerRadius: CGFloat = 8
        private init() {}

        static func decorate(_vc: ViewController) {
            _vc.singInButton.layer.cornerRadius = buttonCornerRadius
            _vc.singInButton.layer.borderColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
        }
    }
}
