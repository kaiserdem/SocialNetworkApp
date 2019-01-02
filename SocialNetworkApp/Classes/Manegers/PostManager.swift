//
//  PostManager.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 31.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation
import Firebase

final class PostManager: FirebaseMamager { //
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
        userRef.child(user.uid).child(Keys.posts.rawValue).child(postID).setValue(dictionary) { (error, reference) in
            if let error = error?.localizedDescription {
                completion(.error(error))
                return
            }
            completion(.success)
        }
    }
    func loadingAllPost(completion: @escaping ItemClosure<Result>) {
        userRef.observe(.value) { (snapshot) in
            var result:[Post] = []// пустой масив постов для заполнения
            guard let value = snapshot.value as? [[AnyHashable: Any]] else {
                completion(.error("Post not exists")) // если не существует
                return
            }
            for element in value {
                if let postsDictionaryArray = (element[Keys.posts] as? [[AnyHashable: Any]]) {
                    let posts = postsDictionaryArray.compactMap { try? Post.init(from: $0) }
                    result.append(contentsOf: posts)
                }
            }
            completion(.seccess(result))
        }
    }
    
}
extension PostManager {
    fileprivate enum Keys: String {
        case posts
    }
}
