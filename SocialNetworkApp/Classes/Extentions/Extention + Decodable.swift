//
//  Extention + Decodable.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 05.01.2019.
//  Copyright © 2019 Yaroslav Golinskiy. All rights reserved.
//

import Foundation

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    self = try decoder.decode(Self.self, from: data)
  }
}
