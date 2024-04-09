//
//  TaskVIewModel.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation
import Combine


final class TaskViewModel:ObservableObject {
    
    @Published var task: [Task] = []
    @Published var errorMessage : String = ""
    @Published var showError : Bool = false
    private var cancellable = Set<AnyCancellable>()
    private var isCompleted = false
    var shouldDismiss =  PassthroughSubject<Bool,Never>()
    
    private let taskReposiory: TaskRepository
    
    init(taskReposiory: TaskRepository) {
        self.taskReposiory = taskReposiory
    }
    deinit {
        self.cancelSubcription()
    }
    func cancelSubcription() {
        cancellable.forEach{
            $0.cancel()
        }
    }
    
    func addTask(task: Task){
        
        taskReposiory.add(task: task)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] operationResult in
                self?.processOperationResult(operationResult: operationResult)
            }.store(in: &cancellable)
    }
    
    func getTask(isCompleted: Bool) {
        self.isCompleted = isCompleted
        taskReposiory.get(isCompleted: !isCompleted)
            .sink{[weak self] operationResult in
                switch operationResult{
            case .success(let fetchedTask):
                self?.errorMessage = ""
                DispatchQueue.main.async {
                    self?.task = fetchedTask
                }
            case .failure(let failure):
                    self?.processOperationError(failure)
            }
            }.store(in: &cancellable)
    }
    
    func updateTask(task: Task) {
        
        taskReposiory.update(task: task)
            .sink {[weak self] operationResult in
                self?.processOperationResult(operationResult: operationResult)
            }.store(in: &cancellable)
    }
    
    func deleteTask(task: Task) {
        
        taskReposiory.delete(task: task)
            .sink { [weak self] operationResult in
                self?.processOperationResult(operationResult: operationResult)
            }.store(in: &cancellable)
    }
    
    func processOperationResult(operationResult: Result<Bool, TaskRepositoryError>){
        switch operationResult{
        case .success(_):
            self.errorMessage = ""
            getTask(isCompleted: isCompleted)
            shouldDismiss.send(true)
        case .failure(let failure):
            processOperationError(failure)
        }
        
    }
    
    func processOperationError(_ error: TaskRepositoryError){
        switch error{
        case .operationFailure(let errorMessage):
            self.showError = true
            self.errorMessage = errorMessage
        }
    }
    
    
    
    
}
