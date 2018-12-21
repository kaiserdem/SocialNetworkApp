//
//  PhotoView.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class PhotoView: UIView, NibLoadable {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }

}

extension PhotoView {
    fileprivate final class Decorator {
        static func decorator(_ view: PhotoView) {
            view.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        }
    }
}
