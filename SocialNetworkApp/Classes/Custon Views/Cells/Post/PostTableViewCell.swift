//
//  PostTableViewCell.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 02.01.2019.
//  Copyright © 2019 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var  textView: UITextView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
