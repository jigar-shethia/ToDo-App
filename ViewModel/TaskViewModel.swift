//
//  TaskVIewModel.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation

final class TaskViewModel:ObservableObject {
    @Published var task: [Task] = []
    
    func getTask(isActive: Bool) {
        task = Task.createMockTask().filter({$0.isActive == isActive})
    }
    
    
}
