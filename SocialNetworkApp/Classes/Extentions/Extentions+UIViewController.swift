//
//  Extentions+UIViewController.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 25.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    // показать алкрт контроллер 
    func showAlert(with titel: String, and message: String) {
        let alertController = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
