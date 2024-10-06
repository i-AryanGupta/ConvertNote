//
//  LoginInteractor.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func loginUser(email: String, password: String) -> Bool
}

class LoginInteractor: LoginInteractorProtocol {
    
    func loginUser(email: String, password: String) -> Bool {
        return CoreDataManager.shared.loginUser(email: email, password: password)
    }
}
