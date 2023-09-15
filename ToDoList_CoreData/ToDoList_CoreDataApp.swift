//
//  ToDoList_CoreDataApp.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import SwiftUI

@main
struct ToDoList_CoreDataApp: App {
    
    @StateObject var vm = GroupViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .tint(.mint)
                .environmentObject(vm)
        }
    }
}
