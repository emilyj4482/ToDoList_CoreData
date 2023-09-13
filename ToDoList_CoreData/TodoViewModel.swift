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
        getGroups()
        print(groups)
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
        save()
        print(groups)
    }
    
    func deleteGroup(_ item: Group) {
        cm.context.delete(item)
        save()
    }
    
    private func save() {
        cm.saveData()
        getGroups()
    }
}

// 문자열 앞뒤 공백 삭제 메소드 정의
extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
