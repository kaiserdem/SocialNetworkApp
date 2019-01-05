//
//  PostManager.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 31.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation
import Firebase

final class PostManager: FirebaseManager { //
    enum Result {
        case seccess([Post]) //возвращаеться масив постов
        case error(String)
    }
    
    private override init() {}
    
    static let shared = PostManager()
    
            // функция создания поста
    func createPost(from user: User, with text: String, completion: @escaping ItemClosure<FirebaseResult>) {
    
        let postID = UUID().uuidString // генерируем айди
        let post = Post(text: text)
        
        guard let dictionary = post.dictionary else {//если получилось сконвертировать в dict
            completion(.error("Post model not dictionary"))// если нет тогда ошибка
            return
        }
        // обращаемся к ветке по айди пользователя, создаем новую ветку
      usersRef.child(user.uid).child(Keys.posts.rawValue).child(postID).setValue(dictionary) { (error, reference) in
            if let error = error?.localizedDescription {
                completion(.error(error))
                return
            }
            completion(.success)
        }
    }
    func loadingAllPost(completion: @escaping ItemClosure<Result>) {
        usersRef.observe(.value) { (snapshot) in
            var result:[Post] = []   // пустой масив постов для заполнения
            
            guard let value = snapshot.value as? [String: [AnyHashable: Any]] else {
                completion(.error("Post not exists")) // если не существует
                return
            }
            let allKeys = value.keys
            allKeys.forEach({ (key) in
                
              if let element = value[key], let postsDictionaryArray = (element[Keys.posts.rawValue] as? [String: [AnyHashable: Any]]) {
                let posts = postsDictionaryArray.compactMap { try? Post.init(from: $0.value as! Decoder) }
                result.append(contentsOf: posts)
              }
            })
            completion(.seccess(result))
        }
    }
    
}
extension PostManager {
    fileprivate enum Keys: String {
        case posts
    }
}
