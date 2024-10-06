//
//  SignupPresenter.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    func signup(username: String, email: String, password: String)
    func navigateToLogin()
}

class SignupPresenter: SignupPresenterProtocol {
    
    weak var view: SignupViewProtocol?
    var interactor: SignupInteractorProtocol?
    var router: SignupRouterProtocol?
    
    init(view: SignupViewProtocol, interactor: SignupInteractorProtocol, router: SignupRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func signup(username: String, email: String, password: String) {
        if interactor?.createUser(username: username, email: email, password: password) == true {
            router?.navigateBackToLogin()
        } else {
            view?.showSignupError(message: "Unable to create user. Email may already be registered.")
        }
    }
    
    func navigateToLogin() {
        router?.navigateBackToLogin()
    }
}
