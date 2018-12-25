//
//  TextFieldCellTableViewCell.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 22.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class TextFieldCellTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var textField: UITextField!
    
    // отдает екшен что текст изменился и передает сам текст
    var textChanged: ItemClosure<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTargets()
    }

    private func addTargets() {
        textField.addTarget(self, action: #selector( textFieldChanged(sender:)), for: .editingChanged)
    }
    @objc private func textFieldChanged(sender: UITextField) {
        textChanged?(sender.text ?? "")
    }
}
