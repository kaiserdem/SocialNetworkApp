//
//  Extention + Encodable.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 31.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any]}
    }
}
