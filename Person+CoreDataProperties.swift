//
//  Person+CoreDataProperties.swift
//  CoreDataPerson
//
//  Created by Руслан Жигалов on 27.01.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var country: String?
    @NSManaged public var birth: Int16

}

extension Person : Identifiable {

}
