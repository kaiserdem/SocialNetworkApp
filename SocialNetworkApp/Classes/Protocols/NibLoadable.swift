//
//  NibLoadable.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

protocol NibLoadable: class { // протокол позволяет получать доступ к nib
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    static var name: String { // получаем имя
        return String(describing: self)
    }
}
extension NibLoadable where Self: UIView {
    // функция загружает вю из файла
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
}
