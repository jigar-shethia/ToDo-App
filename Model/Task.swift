//
//  Task.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation

struct Task: Identifiable {
    let id: Int
    var name: String
    var description: String
    var isActive: Bool
    var finishDate: Date
    
    static func createMockTask() -> [Task] {
        return [Task(id: 1, name: "Go to gym", description: "back workout", isActive: true, finishDate: Date()),
                Task(id: 2, name: "Car wash", description: "Downtown car wash center", isActive: true, finishDate: Date()),
                Task(id: 3, name: "Office work", description: "Finish picker module", isActive: false, finishDate: Date())]
    }
}

enum TaskState: String, CaseIterable {
    case active = "Active"
    case complted = "Completed"
}
