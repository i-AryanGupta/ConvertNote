//
//  LoginRouter.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    static func createLoginModule() -> UIViewController
    func navigateToSignup()
    func navigateToMainView()
}

class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToSignup() {
        let signupVC = SignupRouter.createSignupModule()
        viewController?.navigationController?.pushViewController(signupVC, animated: true)
    }

    func navigateToMainView() {
        let mainVC = MainRouter.createMainModule()
        viewController?.navigationController?.setViewControllers([mainVC], animated: true)
    }
}
