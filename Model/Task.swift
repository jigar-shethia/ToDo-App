//
//  Task.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation

struct Task: Identifiable {
    
    let id: UUID
    var name: String
    var description: String
    var isCompleted: Bool
    var finishDate: Date
    
    init(id: UUID, name: String, description: String, isCompleted: Bool, finishDate: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.isCompleted = isCompleted
        self.finishDate = finishDate
    }
    
    init(){
        self.id = UUID()
        self.name = ""
        self.description = ""
        self.isCompleted = false
        self.finishDate = Date()
    }
    
    
    static func createMockTask() -> [Task] {
        return [Task(id: UUID(), name: "Go to gym", description: "back workout", isCompleted: false, finishDate: Date()),
                Task(id: UUID(), name: "Car wash", description: "Downtown car wash center", isCompleted: false, finishDate: Date()),
                Task(id: UUID(), name: "Office work", description: "Finish picker module", isCompleted: true, finishDate: Date())]
    }
}

enum TaskState: String, CaseIterable {
    case active = "Active"
    case complted = "Completed"
}
