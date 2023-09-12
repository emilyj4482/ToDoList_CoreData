//
//  TodoViewModel.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import SwiftUI
import CoreData

class TodoViewModel: ObservableObject {
    
    let cm = CoreDataManager.instance
    
    @Published var groups: [Group] = []
    @Published var tasks: [Task] = []
    
    init() {
        
    }
    
    func getGroups() {
        let request = NSFetchRequest<Group>(entityName: "Group")
        
        do {
            groups = try cm.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING >>> \(error)")
        }
    }
    
    func addGroup(_ name: String) {
        let newGroup = Group(context: cm.context)
        newGroup.name = name
    }
    
    func deleteGroup() {
        
    }
}
