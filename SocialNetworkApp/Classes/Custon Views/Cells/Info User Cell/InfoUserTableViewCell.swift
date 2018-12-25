//
//  InfoUserTableViewCell.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 21.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell, StaticCellProtocol {

    @IBOutlet private weak var backgroundFieldView: UIView!
    
    @IBOutlet private weak var photoView: PhotoView! // аутлет фотографии
    @IBOutlet private weak var topTextField: UITextField!
    @IBOutlet private weak var bottomTextField: UITextField!

    static var heigth: CGFloat { // высота
        return 100
    }
    var photoViewClicked: VoidClosure? {
        didSet { // при изменении photoViewClicked меняем внутри photoView
            photoView.clicked = photoViewClicked
        }
    }
    // отдает екшен что текст изменился и передает сам текст
    var topTextChanged: ItemClosure<String>?
    var bottomTextChanged: ItemClosure<String>?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        Decoretor.decorator(cell: self)
        addTargets()
    }
    private func addTargets(){
        topTextField.addTarget(self, action: #selector(topTextFieldChanged(sender:)), for: .editingChanged)
        
        bottomTextField.addTarget(self, action: #selector(bottomTextFieldChanged(sender:)), for: .editingChanged)
    }
    @objc private func topTextFieldChanged(sender: UITextField){
        topTextChanged?(sender.text ?? "")
        
    }
    @objc private func bottomTextFieldChanged(sender: UITextField){
        bottomTextChanged?(sender.text ?? "")
    }
    func set(image: UIImage?) { 
        photoView.set(image: image)
    }
}
extension InfoUserTableViewCell {
    fileprivate class Decoretor {
        static func decorator(cell: InfoUserTableViewCell) {
            cell.selectionStyle = .none // что б ячейка не выделялась
            cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
            cell.backgroundFieldView.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
            cell.backgroundFieldView.layer.borderWidth = 0.5
        }
    }
}
