//
//  PhotoView.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class PhotoView: UIView, NibLoadable {
    
    private let plusView = UIImageView()
    private let lable = UILabel()
    
    var clicked: VoidClosure? // кложер по нажатию
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        Decorator.decorator(self)
        addLable()
        addPlusView()
    }
    // нажатие на екрен закончилось
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        clicked?() // вызываем функцию
    }
    
    private func addLable() {
        lable.text = " photo"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
        addSubview(lable)
        
        let constraints = NSLayoutConstraint.constraints(withNewVisyalFormat: "H:|[lable]|,V:|-45-[lable]", dict: ["lable": lable])
        addConstraints(constraints)
    }
    
    private func addPlusView() { //красит кнопку в свой цвет
        plusView.translatesAutoresizingMaskIntoConstraints = false
        plusView.contentMode = .scaleAspectFit
        plusView.tintColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
        plusView.image = #imageLiteral(resourceName: "plus (1)")
        addSubview(plusView)
        
        let constraints = NSLayoutConstraint.constraints(withNewVisyalFormat: "H:|[plusView]|,V:|-15-[plusView(\(frame.height * 0.4))][lable]", dict: ["lable": lable, "plusView": plusView])
        addConstraints(constraints)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        Decorator.layoutSubviews(self)
    }
}

extension PhotoView {
    fileprivate final class Decorator {
        static func decorator(_ view: PhotoView) {
            view.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
            view.layer.borderWidth = 1
        }
        
        static func layoutSubviews(_ view: PhotoView) {
            view.round()
        }
    }
}
