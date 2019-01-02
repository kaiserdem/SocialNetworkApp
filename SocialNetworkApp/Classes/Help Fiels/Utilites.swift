//
//  Utilites.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 26.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit

func ID() -> String {
    let str = "fsdvfdbvgfbndfg5634564356345"
    let arr = Array(str)
    func random() -> String {
        return String(describing: arr[Int.random(in: arr.indices)])
        
    }
    var result = ""
    let countOfCharacters = 12
    for _ in 0..<countOfCharacters {
        result += random()
    }
    return result
}
public func onMain(block: @escaping () -> Void) { // выполняеться на главном потоке
    DispatchQueue.main.async {
        block()
    }
}
