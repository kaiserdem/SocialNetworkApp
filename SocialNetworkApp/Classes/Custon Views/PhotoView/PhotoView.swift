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
    private var imageView = UIImageView()
    
    var clicked: VoidClosure? // кложер по нажатию
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        Decorator.decorator(self)
        addLable()
        addPlusView()
        addImageView()
        clipsToBounds = true
    }
    
    // нажатие на екрен закончилось
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        clicked?() // вызываем функцию
    }
    func set(image: UIImage?) {
        imageView.image = image
        imageView.isHidden = image == nil // показать если картинка не нил
        
    }
    private func addImageView() { // добавления картинки
        // для добавления констренов через код
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true // изначально фото не видно
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        let constrains = NSLayoutConstraint.constraints(withNewVisyalFormat: "H:|[imageView]|,V:[imageView]|", dict: ["imageView": imageView])
        addConstraints(constrains)
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
    
    private func addPlusView() { 
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
    fileprivate final class Decorator { // разрисовывает вю
        static func decorator(_ view: PhotoView) {
            view.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
            view.layer.borderWidth = 1
        }
        
        static func layoutSubviews(_ view: PhotoView) {
            view.round()
           // view.imageView.round()
        }
    }
}
