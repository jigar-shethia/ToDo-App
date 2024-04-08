//
//  TaskViewModelFactory.swift
//  ToDo App
//
//  Created by Jigar Shethia on 08/04/24.
//

import Foundation

final class TaskViewModelFactory {
    static func createTaskViewModel() -> TaskViewModel {
        return TaskViewModel(taskReposiory: TaskRepositoryImplementation())
    }
    
}
