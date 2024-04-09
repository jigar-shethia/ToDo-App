//
//  TaskRepository.swift
//  ToDo App
//
//  Created by Jigar Shethia on 08/04/24.
//
import CoreData.NSManagedObject
import Foundation
import Combine

protocol TaskRepository {
    func get(isCompleted:Bool) -> AnyPublisher<Result<[Task], TaskRepositoryError>,Never>
    func add(task:Task) -> AnyPublisher<Result<Bool,TaskRepositoryError>,Never>
    func update(task:Task) ->  AnyPublisher<Result<Bool,TaskRepositoryError>,Never>
    func delete(task:Task) ->  AnyPublisher<Result<Bool,TaskRepositoryError>,Never>
}

final class TaskRepositoryImplementation :TaskRepository {
    
    private let managedObjectContext: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func get(isCompleted: Bool) -> AnyPublisher<Result<[Task], TaskRepositoryError>,Never> {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        do{
            let result = try managedObjectContext.fetch(fetchRequest)
            if(!result.isEmpty) {
                
                let taskList = result.map({Task(id: $0.id!, name: $0.name ?? "", description: $0.taskDescription ?? "", isCompleted: $0.isCompleted  , finishDate: $0.finsihDate ?? Date() )})
            
                return Just(.success(taskList)).eraseToAnyPublisher()
            }
            
            return Just(.success([])).eraseToAnyPublisher()
        }
        catch {
            managedObjectContext.rollback()
            print("error = \(error.localizedDescription)")
            return Just(.failure(.operationFailure("Unable to fetch the data"))).eraseToAnyPublisher()
        }
        
    }
    
    func add(task: Task) -> AnyPublisher<Result<Bool,TaskRepositoryError>,Never>{
        
        let taskEntity = TaskEntity(context:managedObjectContext)
        taskEntity.id = UUID()
        taskEntity.isCompleted = task.isCompleted
        taskEntity.finsihDate = task.finishDate
        taskEntity.taskDescription = task.description
        taskEntity.name = task.name
        do{
            try managedObjectContext.save()
            return Just(.success(true)).eraseToAnyPublisher()
        }
        catch{
            managedObjectContext.rollback()
            return Just(.failure(.operationFailure("Unable to Add the data"))).eraseToAnyPublisher()
        }
    }
    
    func update(task: Task) -> AnyPublisher<Result<Bool,TaskRepositoryError>,Never> {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do{
            if let existingTask = try managedObjectContext.fetch(fetchRequest).first{
                existingTask.name = task.name
                existingTask.taskDescription = task.description
                existingTask.finsihDate = task.finishDate
                existingTask.isCompleted = task.isCompleted
                
                try managedObjectContext.save()
                return Just(.success(true)).eraseToAnyPublisher()
            }else{
                return Just(.failure(.operationFailure("No task found with the id"))).eraseToAnyPublisher()
            }
        }catch{
            managedObjectContext.rollback()
            return Just(.failure(.operationFailure("Unable to update the data"))).eraseToAnyPublisher()
        }
    }
    
    func delete(task: Task) -> AnyPublisher<Result<Bool,TaskRepositoryError>,Never> {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do{
            if let extingTask = try managedObjectContext.fetch(fetchRequest).first {
                managedObjectContext.delete(extingTask)
                try managedObjectContext.save()
                return Just(.success(true)).eraseToAnyPublisher()
            }else {
                return Just(.failure(.operationFailure("No task found with the id"))).eraseToAnyPublisher()
            }
            
        }
        catch {
            managedObjectContext.rollback()
            return Just(.failure(.operationFailure("Unable to delete the data"))).eraseToAnyPublisher()
        }
    }
    
    
}
