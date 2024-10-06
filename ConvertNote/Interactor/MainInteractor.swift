//
//  MainInteractor.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

protocol MainInteractorProtocol {
    var presenter: MainPresenterProtocol? { get set }
    
    var notes: [Note] { get }
    func fetchNotes()
    func createNote() -> Note?
    func deleteNoteAt(index: Int)
    func searchNotes(text: String) -> [Note]
    func removeEmptyNotes()
}

class MainInteractor: MainInteractorProtocol {
    var presenter: MainPresenterProtocol?
    
    var notes = [Note]()
    
    func fetchNotes() {
        notes = CoreDataManager.shared.fetchNotes()
    }
    
    func createNote() -> Note? {
        guard let newNote = CoreDataManager.shared.createNote() else {
            // Handle the case where note creation failed (e.g., no logged-in user)
            print("Error: Unable to create a new note. Make sure a user is logged in.")
            return nil
        }

        notes.insert(newNote, at: 0)  // Add the new note at the beginning of the array
        return newNote
    }

    func deleteNoteAt(index: Int) {
        // Make sure the index is valid
                guard index >= 0 && index < notes.count else {
                    print("Error: Attempted to delete a note at an invalid index")
                    return
                }

                // Fetch the latest data from Core Data to make sure the notes array is synchronized
                notes = CoreDataManager.shared.fetchNotes()

                // Double-check the index after fetching the latest data
                guard index >= 0 && index < notes.count else {
                    print("Error: Attempted to delete a note at an invalid index after refreshing data")
                    return
                }

                // First, delete the note from Core Data
                let noteToDelete = notes[index]
                CoreDataManager.shared.deleteNote(noteToDelete)

                // Then, remove the note from the `notes` array to keep the data source in sync
                notes.remove(at: index)

                // Optionally, update the UI by notifying the presenter
//                presenter?.didDeleteNoteSuccessfully()
    }
    
    func searchNotes(text: String) -> [Note] {
        return CoreDataManager.shared.fetchNotes(filter: text)
    }
    
    func removeEmptyNotes() {
        if let firstNote = notes.first,
           firstNote.title.trimmingCharacters(in: .whitespaces).isEmpty &&
           firstNote.text.trimmingCharacters(in: .whitespaces).isEmpty {
            deleteNoteAt(index: 0)
        }
    }
}

