//
//  MainRouter.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject{
    static func createMainModule() -> UIViewController
    func navigateToNoteDetail(noteId: String, noteCell: NoteCell?)
}

class MainRouter: MainRouterProtocol {

    weak var viewController: UIViewController?  // This is used for navigation

    static func createMainModule() -> UIViewController {
        let view = MainViewController()  // The View
        let interactor = MainInteractor() // The Interactor
        let router = MainRouter()         // The Router
        let presenter = MainPresenter(view: view, interactor: interactor, router: router) // The Presenter

        // Wire up the dependencies
        view.presenter = presenter
        router.viewController = view

        return view
    }

    // Implement the navigation method to push NoteViewController
    func navigateToNoteDetail(noteId: String, noteCell: NoteCell?) {
        let noteVC = NoteRouter.createNoteModule(noteId: noteId, noteCell: noteCell)
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }
}

