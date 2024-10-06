//
//  Note+CoreDataProperties.swift
//  ConvertNote
//
//  Created by Yashom on 02/10/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String!
    @NSManaged public var text: String!
    @NSManaged public var id: String!
    @NSManaged public var date: Date!
    @NSManaged public var user: User?

}

extension Note : Identifiable {

}
