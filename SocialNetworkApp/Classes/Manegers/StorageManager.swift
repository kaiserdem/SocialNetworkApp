//
//  StorageManager.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 27.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import UIKit
import FirebaseStorage

class StorageManager { // класс для работы с firebase Storage(менеждер хранилища)
    
    static let shared = StorageManager()
    
    private init() {}
    
    // указывает на первоначальную ветку в базе данных
    private let sourseRef = Storage.storage().reference()

    // принимает фото, возвращает по айди клоужер(опционально)
    func upload(photo: UIImage, by model: RegisterModel, closure: VoidClosure? = nil) {
        guard let data = photo.jpegData(compressionQuality: 0.5) else {//фото уменьш в 0.5раз
            return
        }
        // создаем ветку avatars
        sourseRef.child(Keys.avatars.rawValue).child(model.userId).putData(data, metadata: nil) { (metadata, error) in
            closure?()
        }
    }
    //отправляем id пользователя, возвр url на аватарку
    func loadAvatarUrl(for model: RegisterModel, closure: @escaping OptionalItemClosure<URL>) {
        sourseRef.child(Keys.avatars.rawValue).child(model.userId).downloadURL { (url, error) in
            closure(url)
        }
    }
}
// хранилище для ключей веток
extension StorageManager {
    private enum Keys: String {
        case avatars
    }
}
