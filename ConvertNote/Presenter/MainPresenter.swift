//
//  MainPresenter.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import Foundation
protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    
    func viewDidLoad()
    func viewDidAppear()
    func refreshNotes()
    func didTapAddButton()
    func numberOfRows(isSearching: Bool) -> Int
    func configureCell(cell: NoteCell, index: Int, isSearching: Bool)
    func didSelectNoteAt(index: Int, isSearching: Bool, noteCell: NoteCell?) // Updated to accept NoteCell
    func deleteNoteAt(index: Int)
    func searchNotes(text: String)
}

class MainPresenter: MainPresenterProtocol {
    
    var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?

    private var searchedNotes = [Note]()

    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchNotes()
    }
    
    func refreshNotes() {
            interactor?.fetchNotes()
            view?.showNotes()  // Update the view with the latest notes
        }

    func viewDidAppear() {
        interactor?.removeEmptyNotes()
    }

    func didTapAddButton() {
            // Create a new note
            let newNote = interactor?.createNote()

            // After the note is created, navigate to NoteViewController with the new note's ID
            if let noteId = newNote?.id {
                router?.navigateToNoteDetail(noteId: noteId, noteCell: nil)
            }
        }

    func numberOfRows(isSearching: Bool) -> Int {
        return isSearching ? searchedNotes.count : interactor?.notes.count ?? 0
    }

    func configureCell(cell: NoteCell, index: Int, isSearching: Bool) {
        let note = isSearching ? searchedNotes[index] : interactor?.notes[index]
        cell.configure(note: note!)
        cell.configureLabels()
    }

    func didSelectNoteAt(index: Int, isSearching: Bool, noteCell: NoteCell?) {
        let note = isSearching ? searchedNotes[index] : interactor?.notes[index]
        // Use the router to navigate to the note detail screen
        router?.navigateToNoteDetail(noteId: note?.id ?? "", noteCell: noteCell)
    }

    func deleteNoteAt(index: Int) {
        interactor?.deleteNoteAt(index: index)
    }

    func searchNotes(text: String) {
        searchedNotes = interactor?.searchNotes(text: text) ?? []
        view?.showNotes()
    }
}


