//
//  NoteRouter.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import UIKit
protocol NoteRouterProtocol: AnyObject {
    static func createNoteModule(noteId: String, noteCell: NoteCell?) -> UIViewController
}

class NoteRouter: NoteRouterProtocol {

    static func createNoteModule(noteId: String, noteCell: NoteCell?) -> UIViewController {
        let view = NoteViewController()  // The View
        let interactor = NoteInteractor() // The Interactor
        let router = NoteRouter()         // The Router
        let presenter = NotePresenter(view: view, interactor: interactor, router: router, noteId: noteId, noteCell: noteCell)

        // Wire up the dependencies
        view.presenter = presenter

        return view
    }
}


