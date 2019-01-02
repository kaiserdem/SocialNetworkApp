//
//  NibLoadable.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit
                   // class протоколом может быть только класс
protocol NibLoadable: class { // протокол позволяет получать доступ к nib
    static var nib: UINib { get }
}
extension NibLoadable {
    static var nib: UINib {
        //возвращает имя класса от которого наследуем протокол
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    static var name: String { // получаем имя
        return String(describing: self)
    }
}
// класс от которого наследуеться протокол являеться UIView
extension NibLoadable where Self: UIView {
    // функция загружает вю из файла
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError() // существует ли такое вю
        }
        return view
    }
}
