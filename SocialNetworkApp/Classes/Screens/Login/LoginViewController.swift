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

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
        title = "Enter"

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
        AuthManeger.shared.singIn(with: email, and: password) { (result) in
            switch result {
            case .success:
                self.showAlert(with: "Successfully", and: "You are logged in")
            case .error(let error):
                self.showAlert(with: "Error", and: error)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // большие буквы контроллера
        navigationController?.navigationBar.prefersLargeTitles = true
        // добавили нав контроллер
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


}
