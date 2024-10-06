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
    
    // The currently logged-in user
    var currentUser: User?

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

    // MARK: - User Management
    
    // Create a new user
    func createUser(username: String, email: String, password: String) -> User? {
        // Check if user already exists
        if fetchUserByEmail(email: email) != nil {
            return nil // User already exists
        }
        
        let user = User(context: viewContext)
        user.userId = UUID()
        user.username = username
        user.email = email
        user.password = password
        save()
        return user
    }

    // Fetch a user by email (for checking if user already exists)
    func fetchUserByEmail(email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return (try? viewContext.fetch(request))?.first
    }

    // Log in the user by checking credentials
    func loginUser(email: String, password: String) -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        if let user = (try? viewContext.fetch(request))?.first {
            currentUser = user // Set the logged-in user
            return true
        }
        return false // Invalid login credentials
    }

    // Log out the user
    func logoutUser() {
        currentUser = nil
        print("User logged out successfully.")
    }

    // MARK: - Note Management

    // Create a new note for the current logged-in user
    func createNote() -> Note? {
        guard let user = currentUser else {
            print("Error: No user is logged in")
            return nil
        }

        let note = Note(context: viewContext)
        note.title = ""
        note.text = ""
        note.id = UUID().uuidString
        note.date = Date()
        note.user = user // Associate the note with the logged-in user
        save()
        return note
    }
    
    // Saving data to Core Data
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error occurred while saving data: \(error.localizedDescription)")
            }
        }
    }
    
    // Fetch notes for the current logged-in user, with optional filtering
    func fetchNotes(filter: String? = nil) -> [Note] {
        guard let user = currentUser else {
            print("Error: No user is logged in")
            return []
        }

        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "user == %@", user)

        // Apply additional filtering if provided
        if let filter = filter {
            let pr1 = NSPredicate(format: "title contains[cd] %@", filter)
            let pr2 = NSPredicate(format: "text contains[cd] %@", filter)
            let filterPredicate = NSCompoundPredicate(type: .or, subpredicates: [pr1, pr2])
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [request.predicate!, filterPredicate])
        }

        return (try? viewContext.fetch(request)) ?? []
    }
    
    // Delete a note for the current user
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
