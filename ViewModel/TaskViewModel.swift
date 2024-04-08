//
//  TaskVIewModel.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation

final class TaskViewModel:ObservableObject {

    @Published var task: [Task] = []
    private let taskReposiory: TaskRepository
    
    init(taskReposiory: TaskRepository) {
        self.taskReposiory = taskReposiory
    }
     
    
    func addTask(task: Task) -> Bool {
       
        return taskReposiory.add(task: task)
    }
    
    func getTask(isCompleted: Bool) {
        self.task = taskReposiory.get(isCompleted: !isCompleted)
    }
    
    func updateTask(task: Task) -> Bool {
        
        return taskReposiory.update(task: task)
    }
    
    func deleteTask(task: Task) -> Bool {

        return taskReposiory.delete(task: task)
    }
    
    
}
