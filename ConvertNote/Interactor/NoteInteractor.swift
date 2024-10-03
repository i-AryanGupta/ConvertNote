//
//  NoteInteractor.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import Foundation

protocol NoteInteractorProtocol: AnyObject {
    var note: Note? { get }
    func fetchNote(with id: String)
    func updateNoteTitle(title: String)
    func updateNoteText(text: String)
    func saveNote()
}

class NoteInteractor: NoteInteractorProtocol {
    
    var note: Note?
    
    func fetchNote(with id: String) {
        // Use CoreDataManager to fetch notes
        let notes = CoreDataManager.shared.fetchNotes()

        // Find the note with the matching id
        note = notes.first(where: { $0.id == id })
    }
    
    func updateNoteTitle(title: String) {
        note?.title = title
    }
    
    func updateNoteText(text: String) {
        note?.text = text
    }
    
    func saveNote() {
        CoreDataManager.shared.save()
    }
}

