//
//  CreatePostViewController.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 31.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()

    }


    private func addTargets() { // нажатие на кнопку
        doneButton.addTarget(self, action: #selector(doneButtonClocked), for: .touchUpInside)
    }
    @objc private func doneButtonClocked() {
        guard let text = textView.text, !text.isEmpty else { // если пост не пустой
            showAlert(with: "Error", and: "Text is empty")
            return
        }
        guard let user = AuthManeger.shared.currentUser else { // проверка юзера
            showAlert(with: "Error", and: "User not logged in")
            return
        }
        
        PostManager.shared.createPost(from: user, with: text) { (result) in
            switch result {
            case .error(let textError):
                self.showAlert(with: "Error", and: textError)
                
            case .success:
                self.showAlert(with: "Succes", and: "Post has been created")
            }
        }
    }
}
