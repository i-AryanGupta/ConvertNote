//
//  CoreDataManager.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager(modelName: "ConvertNote")

    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Init method
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        load() // Make sure the persistent store is loaded
    }
    
    // Loading persistent stores
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
            } else {
                print("Core Data stack successfully loaded from \(description.url?.absoluteString ?? "Unknown URL")")
            }
            completion?()
        }
    }

    // Create a new note
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.title = ""
        note.text = ""
        note.id = UUID().uuidString
        note.date = Date()
        save()
        return note
    }
    
    // Saving notes to database
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error occurred while saving data: \(error.localizedDescription)")
            }
        }
    }
    
    // Fetch notes with optional filtering
    func fetchNotes(filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        // Filtering notes
        if let filter = filter {
            let pr1 = NSPredicate(format: "title contains[cd] %@", filter)
            let pr2 = NSPredicate(format: "text contains[cd] %@", filter)
            let predicate = NSCompoundPredicate(type: .or, subpredicates: [pr1, pr2])
            request.predicate = predicate
        }
        return (try? viewContext.fetch(request)) ?? []
    }
    
    // Delete a note
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
