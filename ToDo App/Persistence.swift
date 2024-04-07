//
//  Persistence.swift
//  ToDo App
//
//  Created by Jigar Shethia on 06/04/24.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDo_App")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        viewContext = container.viewContext
    }
}
