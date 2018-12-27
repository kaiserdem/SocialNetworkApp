//
//  UserHeaderView.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 27.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class UserHeaderView: UIView, NibLoadable {
    
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private  weak var userNameLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.round()
    }
}
