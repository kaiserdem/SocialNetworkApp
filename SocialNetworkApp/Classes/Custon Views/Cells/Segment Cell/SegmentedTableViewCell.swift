//
//  SegmentedTableViewCell.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 22.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

class SegmentedTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    var indexChanged: ItemClosure<Int>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none // ячейки нельзя выделять
        addTargets()
    }
    private func addTargets() {
        segmentControl?.addTarget(self, action: #selector(segmentContolChangedIndex(sender:)), for: .valueChanged)
    }
    @objc private func segmentContolChangedIndex(sender: UISegmentedControl) {
        indexChanged?(sender.selectedSegmentIndex)
    }
}
