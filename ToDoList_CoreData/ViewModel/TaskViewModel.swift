//
//  TaskViewModel.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/14.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    
    static let shared = TaskViewModel()
    let cm = CoreDataManager.instance
    
    @Published var tasks: [Task] = []

    func getTasks(for group: Group) {
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        let filter = NSPredicate(format: "group == %@", group)
        request.predicate = filter
        
        do {
            tasks = try cm.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING TASKS FOR \(String(describing: group.name)) >>> \(error)")
        }
    }
    
    func addTask(_ title: String, to group: Group) {
        let newTask = Task(context: cm.context)
        newTask.title = title
        newTask.group = group
        
        save(to: group)
    }
    
    func updateTask(to group: Group) {
        save(to: group)
    }
    
    func deleteTask(_ item: Task, from group: Group) {
        cm.context.delete(item)
        save(to: group)
    }
    
    private func save(to group: Group) {
        cm.saveData()
        getTasks(for: group)
        printTasks()
    }
    
    func printTasks() {
        for task in tasks {
            guard let title = task.title else { return }
            print("TASK >>> \(title)\n   Task isDone >> \(task.isDone)\n   Task isImportant >> \(task.isImportant)\n ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
        }
    }
}
