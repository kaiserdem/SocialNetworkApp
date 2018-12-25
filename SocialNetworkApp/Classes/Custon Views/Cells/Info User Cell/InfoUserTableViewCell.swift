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

    static var heigth: CGFloat { // высота
        return 100
    }
    var photoViewClicked: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Decoretor.decorator(cell: self)
        photoView.clicked = photoViewClicked // нажатие на фото
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
