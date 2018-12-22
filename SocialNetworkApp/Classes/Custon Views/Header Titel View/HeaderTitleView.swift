//
//  HeaderTitleView.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 22.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class HeaderTitleView: UIView, NibLoadable {
    @IBOutlet private weak var lable: UILabel!
    
    func set(title: String) {
        lable.text = title
    }
}
