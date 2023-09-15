//
//  GroupViewModel.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import SwiftUI
import CoreData

class GroupViewModel: ObservableObject {
    
    static let shared = GroupViewModel()
    let cm = CoreDataManager.instance
    
    @Published var groups: [Group] = []
    
    init() {
        getGroups()
        printGroups()
    }
    
    func printGroups() {
        for group in groups {
            guard let name = group.name else { return }
            print("GROUP >>> \(name)")
            guard let tasks = group.tasks else { return }
            for task in tasks {
                guard let todo = task as? Task else{ return }
                print(
                    "  Task title >> \(todo.title ?? "")\n  Task isDone >> \(todo.isDone)\n  Task isImportant >> \(todo.isImportant)\n ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ"
                )
            }
        }
    }
    
    func getGroups() {
        let request = NSFetchRequest<Group>(entityName: "Group")
        
        do {
            groups = try cm.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING GROUPS >>> \(error)")
        }
    }
    
    func addGroup(_ name: String) {
        let newGroup = Group(context: cm.context)
        newGroup.id = UUID()
        newGroup.name = name
        save()
    }
    
    func deleteGroup(_ item: Group) {
        cm.context.delete(item)
        save()
    }
    
    func updateGroup(_ item: Group, name: String) {
        item.name = name
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
