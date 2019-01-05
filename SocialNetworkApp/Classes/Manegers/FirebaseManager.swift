//
//  FirebaseManager.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 05.01.2019.
//  Copyright © 2019 Yaroslav Golinskiy. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
  var sourceRef: DatabaseReference {
    return Database.database().reference()
  }
  
  var usersRef: DatabaseReference {
    return sourceRef.child("users")
  }
}
