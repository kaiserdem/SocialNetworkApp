//
//  Typealiases.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 21.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation

typealias StaticCellProtocol = NibLoadable & HeigtContainable

typealias ItemClosure<T> = ((T) -> Void) // дженерик

typealias VoidClosure = (() -> Void) // клоужер
