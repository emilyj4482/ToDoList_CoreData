//
//  TaskViewModel.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/14.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    
    let cm = CoreDataManager.instance
    
    @Published var tasks: [Task] = []
    
    init() {
        getTasks()
    }
    
    private func getTasks() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        do {
            tasks = try cm.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING TASKS >>> \(error)")
        }
    }
    
    func addTask(_ title: String) {
        let newTask = Task(context: cm.context)
        newTask.id = UUID()
        newTask.title = title
    }
    
    private func save() {
        cm.saveData()
        getTasks()
    }
}
