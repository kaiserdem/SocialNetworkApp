//
//  LoginViewController.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 27.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet private weak var authButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
        title = "Enter"
        addTargets()
        
        Decorator.decorate(self)
    }
    private func addRightButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = button // кладем на нав бар
    }
    @objc private func doneButtonClicked() {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !email.isEmpty && !password.isEmpty else { // если пустые
            showAlert(with: "Error", and: "Fill in the fields!")
            return
        } // в противном случае
        self.performLogin(email: email, password: password)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // большие буквы контроллера
        navigationController?.navigationBar.prefersLargeTitles = true
        // добавили нав контроллер
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
private extension LoginViewController {
    final class Decorator {
        static func decorate(_ vc: LoginViewController) {
            let biometricType = BiometricAuthManager.shared.biometricType()
            switch biometricType {
            case .touchID:
                vc.authButton.setImage(#imageLiteral(resourceName: "touchId"), for: .normal)
            case .faceID:
                vc.authButton.setImage(#imageLiteral(resourceName: "faceId"), for: .normal)
            case .none:
                vc.authButton.setImage(#imageLiteral(resourceName: "touch_id"), for: .normal)
                vc.authButton.isEnabled = false
            }
        }
    }
}

private extension LoginViewController {
    func addTargets() {
        authButton.addTarget(self, action: #selector(authButtonClicked), for: .touchUpInside)
    }
    
    func performLogin(email: String?, password: String?) {
        AuthManeger.shared.signIn(with: email, and: password) { (result) in
            switch result {
            case .success:
                StartRouter.shared.routerAfterSuccessAuth(from: self)
            case .error(let error):
                self.showAlert(with: "Ошибка", and: error)
            }
        }
    }
    
    @objc func authButtonClicked() {
        BiometricAuthManager.shared.authenticateUser { (error) in
            if let error = error {
                self.showAlert(with: "Ошибка", and: error.errorDescription ?? "Unexpected result")
                return
            }
            let userInfo = SecureStorageManager.shared.loadEmailAndPassword()
            self.performLogin(email: userInfo.email, password: userInfo.password)
        }
    }
}
