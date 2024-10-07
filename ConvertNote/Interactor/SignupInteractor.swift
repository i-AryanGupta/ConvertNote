//
//  SignupInteractor.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import Foundation

protocol SignupInteractorProtocol: AnyObject {
    func createUser(username: String, email: String, password: String) -> Bool
}

class SignupInteractor: SignupInteractorProtocol {
    
    func createUser(username: String, email: String, password: String) -> Bool {
        let user = CoreDataManager.shared.createUser(username: username, email: email, password: password)
        return user != nil
    }
}
