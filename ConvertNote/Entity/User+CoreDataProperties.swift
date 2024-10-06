//
//  User+CoreDataProperties.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userId: UUID?
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var notes: NSSet? //Relationship with notes

}

// MARK: Generated accessors for notes
extension User {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension User : Identifiable {

}
