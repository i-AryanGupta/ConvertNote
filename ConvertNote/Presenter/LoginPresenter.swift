//
//  LoginPresenter.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import UIKit

protocol LoginPresenterProtocol: AnyObject {
    func login(email: String, password: String)
    func navigateToSignup()
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    init(view: LoginViewProtocol, interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func login(email: String, password: String) {
        if interactor?.loginUser(email: email, password: password) == true {
            router?.navigateToMainView()
        } else {
            view?.showLoginError(message: "Invalid email or password.")
        }
    }
    
    func navigateToSignup() {
        router?.navigateToSignup()
    }
}
