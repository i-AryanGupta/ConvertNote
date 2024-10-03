//
//  NotePresenter.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import Foundation

protocol NotePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func updateNoteTitle(title: String)
    func updateNoteText(text: String)
}

class NotePresenter: NotePresenterProtocol {
    
    weak var view: NoteViewProtocol?
    var interactor: NoteInteractorProtocol?
    var router: NoteRouterProtocol?
    
    private var noteId: String  // Use String instead of UUID for the note ID
    private var noteCell: NoteCell?

    init(view: NoteViewProtocol, interactor: NoteInteractorProtocol, router: NoteRouterProtocol, noteId: String, noteCell: NoteCell?) {
            self.view = view
            self.interactor = interactor
            self.router = router
            self.noteId = noteId
            self.noteCell = noteCell
        }

    
    func viewDidLoad() {
        interactor?.fetchNote(with: noteId)
    }
    
    func viewWillAppear() {
        guard let note = interactor?.note else { return }
        view?.displayNoteData(title: note.title, text: note.text)
    }
    
    func viewWillDisappear() {
        interactor?.saveNote()
    }
    
    func updateNoteTitle(title: String) {
        interactor?.updateNoteTitle(title: title)
    }
    
    func updateNoteText(text: String) {
        interactor?.updateNoteText(text: text)
    }
}
