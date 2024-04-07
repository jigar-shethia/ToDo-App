//
//  TaskEntity+CoreDataProperties.swift
//  ToDo App
//
//  Created by Jigar Shethia on 08/04/24.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var finsihDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var taskDescription: String?

}

extension TaskEntity : Identifiable {

}
