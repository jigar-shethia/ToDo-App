//
//  TaskVIewModel.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation

final class TaskViewModel:ObservableObject {
    @Published var task: [Task] = []
    private var temTask = Task.createMockTask()
    
    
    func addTask(task: Task) -> Bool {
        let taskId = Int.random(in: 4...100)
        let newTask = Task(id: taskId, name: task.name, description: task.description, isCompleted: task.isCompleted, finishDate: task.finishDate)
        temTask.append(newTask)
        return true
    }
    
    func getTask(isActive: Bool) {
        task = temTask.filter({$0.isCompleted == !isActive})
    }
    
    func updateTask(task: Task) -> Bool {
        if let taskToUpadte = temTask.filter({$0.id == task.id}).first {
            print("Task to update \(taskToUpadte)")
        }
        if let index =  temTask.firstIndex(where: {$0.id == task.id}){
            temTask[index].name = task.name
            temTask[index].description = task.description
            temTask[index].isCompleted = task.isCompleted
            temTask[index].finishDate = task.finishDate
            self.task = temTask
            return true
        }
        return false
    }
    
    func deleteTask(task: Task) -> Bool {
        if let index = temTask.firstIndex(where: {$0.id == task.id}){
            temTask.remove(at: index)
            self.task = temTask
            return true
        }
        return false
    }
    
    
}
