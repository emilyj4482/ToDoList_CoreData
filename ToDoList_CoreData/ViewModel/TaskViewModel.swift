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
    let gvm = GroupViewModel.shared
    
    @Published var tasks: [Task] = []
    
    // isDone 여부에 따른 section 분리
    @Published var undoneTasks: [Task] = []
    @Published var doneTasks: [Task] = []

    func getTasks(for group: Group) {
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        let filter = NSPredicate(format: "ANY group == %@", group)
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
        newTask.addToGroup(group)
        save(to: group)
        reloadSection()
    }
    
    func updateTask(to group: Group) {
        save(to: group)
    }
    
    func deleteTask(_ item: Task, from group: Group) {
        cm.context.delete(item)
        save(to: group)
        reloadSection()
    }
    
    // isImportant toggle 시 Important group에 추가/삭제 동작
    func updateImportant(_ task: Task, to group: Group) {
        let important = gvm.groups[0]
        if task.isImportant {
            task.addToGroup(important)
        } else {
            important.removeFromTasks(task)
        }
        save(to: group)
        gvm.save()
        reloadSection()
    }
    
    // isDone 여부에 따른 section 분리
    func reloadSection() {
        undoneTasks = tasks.filter({ $0.isDone == false })
        doneTasks = tasks.filter({ $0.isDone == true })
    }
    
    private func save(to group: Group) {
        cm.saveData()
        getTasks(for: group)
    }
}
