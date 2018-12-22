//
//  CellHeaderProtocol.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 22.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation

protocol CellHeaderProtocol {
    associatedtype CellType
    
    var cellModels:[CellType] { get }
    
}
