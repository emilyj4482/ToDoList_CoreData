//
//  CoreDataManager.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import CoreData

class CoreDataManager {
    
    // singleton
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "TodoContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA >>> \(error)")
            } else {
                print("CORE DATA LOADED SUCCESSFULLY!")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
            print("SAVED SUCCESSFULLY!")
        } catch let error {
            print("ERROR SAVING CORE DATA >>> \(error.localizedDescription)")
        }
    }
}
