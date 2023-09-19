//
//  TodoListView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/13.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    
    @EnvironmentObject var gvm: GroupViewModel
    @StateObject var tvm = TaskViewModel.shared
    
    @State var group: Group
    
    /* group update */
    @State var showFieldAlert: Bool = false
    @State var newGroupName: String = ""
    
    /* task create & edit */
    @State var showCreate: Bool = false
    @State var showEdit: Bool = false
    @State var taskToEdit: Task?
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(tvm.undoneTasks) { task in
                        TaskHStack(task: task, group: group)
                            .swipeActionModifier(group: $group, task: task, taskToEdit: $taskToEdit, showEdit: $showEdit)
                    }
                }
                
                Section(tvm.doneTasks.count == 0 ? "" : "tasks done!") {
                    ForEach(tvm.doneTasks) { task in
                        TaskHStack(task: task, group: group)
                            .swipeActionModifier(group: $group, task: task, taskToEdit: $taskToEdit, showEdit: $showEdit)
                    }
                }
            }
            .listStyle(.plain)
            
            // Important list에서는 task 추가 불가
            if group.name != "Important" {
                Button {
                    showCreate.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add a Task")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)
                .padding(.bottom, 5)
            }
        }
        .navigationTitle(group.name ?? "N/A")
        .toolbar {
            // Important list는 rename 불가
            if group.name != "Important" {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFieldAlert = true
                    } label: {
                        Text("Rename")
                    }
                    .alert("Enter a new name for the list.", isPresented: $showFieldAlert) {
                        TextField(group.name ?? "", text: $newGroupName)
                        Button("Confirm") {
                            if !newGroupName.trim().isEmpty {
                                gvm.updateGroup(group, name: newGroupName.trim())
                            }
                        }
                        Button("Cancel", role: .cancel, action: {})
                    }
                }
            }
        }
        .sheet(isPresented: $showCreate) {
            NavigationStack {
                TaskEditView(group: group, taskToEdit: $taskToEdit, isCreating: true)
            }
            .presentationDetents([.height(50)])
        }
        .sheet(isPresented: $showEdit) {
            NavigationStack {
                TaskEditView(group: group, taskToEdit: $taskToEdit, isCreating: false)
            }
            .presentationDetents([.height(50)])
        }
        .onAppear {
            tvm.getTasks(for: group)
            tvm.reloadSection()
        }
    }
}
