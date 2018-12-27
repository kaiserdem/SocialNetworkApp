//
//  Typealiases.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 21.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation
                               // обьяденили протоколы  
typealias StaticCellProtocol = NibLoadable & HeigtContainable

typealias ItemClosure<T> = ((T) -> Void) // дженерик

typealias OptionalItemClosure<T> = ((T?) -> Void)

typealias VoidClosure = (() -> Void) // клоужер

typealias ResultHandler<Value> = (Result<Value>) -> Void
