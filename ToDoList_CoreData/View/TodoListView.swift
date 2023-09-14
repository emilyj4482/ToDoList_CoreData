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
    @StateObject var tvm = TaskViewModel()
    
    @State var group: Group
    
    /* group update */
    @State var showFieldAlert: Bool = false
    @State var newGroupName: String = ""
    
    var body: some View {
        
        VStack {
            List {
                ForEach(tvm.tasks) { task in
                    Text(task.title ?? "N/A")
                }
            }
            .listStyle(.plain)

            Button {
                // test code
                tvm.addTask("study iOS", to: group)
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
        .navigationTitle(group.name ?? "N/A")
        .toolbar {
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
                            // 현재 화면 navigation title에도 적용
                            group.name = newGroupName
                        }
                    }
                    Button("Cancel", role: .cancel, action: {})
                }
            }
        }
        .onAppear {
            tvm.getTasks(for: group)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(group: Group(context: NSPersistentContainer(name: "TodoContainer").viewContext))
    }
}
