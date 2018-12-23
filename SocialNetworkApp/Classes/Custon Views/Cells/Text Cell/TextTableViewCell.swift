//
//  TextTableViewCell.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 22.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var lable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    func set(text: String?) {
        lable.text = text
    }
    
}
