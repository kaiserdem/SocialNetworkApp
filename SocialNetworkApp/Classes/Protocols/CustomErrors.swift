//
//  CustomErrors.swift
//  SocialNetworkApp
//
//  Created by Kaiserdem on 27.12.2018.
//  Copyright © 2018 Yaroslav Golinskiy. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value) // успех
    case failure(Error) // отказ
}

enum CustomErrors {
    case invalidEmail // не верный адрес почты
    case unknownError // неизвестная ошибка
    case serverError  // ошибка сервера
    case keychainError
    case biometricAuthError(String)
}

extension CustomErrors: LocalizedError {
    
    var errorDescription: String? {
        switch  self {
        case .invalidEmail:
            return NSLocalizedString("email_is_not_valid", comment: "")
        case .unknownError:
            return NSLocalizedString("server_error", comment: "")
        case .serverError:
            return NSLocalizedString("server_error", comment: "")
        case .keychainError:
            /// generally, user shouldn't know about this error
            /// because it is secure storage
            return NSLocalizedString("keychain_error", comment: "")
        case .biometricAuthError(let error):
            return error
        }
    }
}
