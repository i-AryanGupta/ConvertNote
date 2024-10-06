//
//  SignupRouter.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import UIKit

protocol SignupRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createSignupModule() -> UIViewController
    func navigateBackToLogin()
}

class SignupRouter: SignupRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createSignupModule() -> UIViewController {
        let view = SignupViewController()
        let interactor = SignupInteractor()
        let router = SignupRouter()
        let presenter = SignupPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateBackToLogin() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
