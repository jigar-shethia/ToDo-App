//
//  TaskRepository.swift
//  ToDo App
//
//  Created by Jigar Shethia on 08/04/24.
//
import CoreData.NSManagedObject
import Foundation

protocol TaskRepository {
    func get(isCompleted:Bool) -> [Task]
    func add(task:Task) -> Bool
    func update(task:Task) -> Bool
    func delete(task:Task) -> Bool
}

final class TaskRepositoryImplementation :TaskRepository {
    
    private let managedObjectContext: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func get(isCompleted: Bool) -> [Task] {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        do{
            let result = try managedObjectContext.fetch(fetchRequest)
            if(!result.isEmpty) {
                return result.map({Task(id: $0.id!, name: $0.name ?? "", description: $0.taskDescription ?? "", isCompleted: $0.isCompleted  , finishDate: $0.finsihDate ?? Date() )})
            }
        }
        catch {
            print("error = \(error.localizedDescription)")
        }
        return[]
    }
    
    func add(task: Task) -> Bool {
        let taskEntity = TaskEntity(context:managedObjectContext)
        taskEntity.id = UUID()
        taskEntity.isCompleted = task.isCompleted
        taskEntity.finsihDate = task.finishDate
        taskEntity.taskDescription = task.description
        taskEntity.name = task.name
        do{
            try managedObjectContext.save()
            return true
        }
        catch{
            print("error on add task")
        }
        return false
    }
    
    func update(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do{
            if let existingTask = try managedObjectContext.fetch(fetchRequest).first{
                existingTask.name = task.name
                existingTask.taskDescription = task.description
                existingTask.finsihDate = task.finishDate
                existingTask.isCompleted = task.isCompleted
                
                try managedObjectContext.save()
                return true
            }else{
                print("No task found with the id \(task.id)")
                return false
            }
            
            
        }catch{
            print("error = \(error.localizedDescription)")
        }
            
        
        return false
    }
    
    func delete(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do{
            if let extingTask = try managedObjectContext.fetch(fetchRequest).first {
                managedObjectContext.delete(extingTask)
                try managedObjectContext.save()
                return true
            }else {
                print("Id not found")
            }
            
        }
        catch {
            print("error = \(error.localizedDescription)")
        }
        
        return false
    }
    
    
}
