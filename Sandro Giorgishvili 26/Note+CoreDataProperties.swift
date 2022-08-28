//
//  Note+CoreDataProperties.swift
//  Sandro Giorgishvili 26
//
//  Created by TBC on 26.08.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var descriptionOfNote: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var id: UUID?

}

extension Note : Identifiable {

}
