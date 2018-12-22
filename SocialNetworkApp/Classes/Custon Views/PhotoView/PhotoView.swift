//
//  PhotoView.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 20.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

final class PhotoView: UIView, NibLoadable {
    
    private let stackView = UIStackView()
    private let plusView = UIImageView()
    private let lable = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addStackView()
        addPlusView()
        addLable()
    }
    
    private func addLable() {
        lable.text = "photo"
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
        stackView.addArrangedSubview(lable)
    }
    
    private func addPlusView() { //красит кнопку в свой цвет
        plusView.contentMode = .scaleAspectFit
        plusView.tintColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
        plusView.image = #imageLiteral(resourceName: "plus (1)")
        stackView.addArrangedSubview(plusView)
    }

    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        addSubview(stackView)
        
        let constraints = NSLayoutConstraint.constraints(withNewVisyalFormat: "H:|-20-[stackView]|,V:|-20-[stackView]|", dict: ["stackView": stackView])
        addConstraints(constraints)
//        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
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
