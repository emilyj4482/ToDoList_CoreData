//
//  TodoListView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/13.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    
    @EnvironmentObject var vm: GroupViewModel
    
    @State var group: Group
    
    /* group update */
    @State var showFieldAlert: Bool = false
    @State var newGroupName: String = ""
    
    var body: some View {
        
        VStack {
            List {
                
            }
            .listStyle(.plain)

            Button {
                
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
                            vm.updateGroup(group, name: newGroupName.trim())
                            // 현재 화면 navigation title에도 적용
                            group.name = newGroupName
                        }
                    }
                    Button("Cancel", role: .cancel, action: {})
                }
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(group: Group(context: NSPersistentContainer(name: "TodoContainer").viewContext))
    }
}
