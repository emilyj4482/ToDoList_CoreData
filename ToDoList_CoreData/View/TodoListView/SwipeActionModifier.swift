//
//  SwipeActionModifier.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/19.
//

import SwiftUI

struct SwipeActionModifier: ViewModifier {
    
    @EnvironmentObject var gvm: GroupViewModel
    @ObservedObject var tvm = TaskViewModel.shared
    
    @Binding var group: Group
    @State var task: Task
    @Binding var taskToEdit: Task?
    @Binding var showEdit: Bool
    
    func body(content: Content) -> some View {
        content
            .swipeActions(allowsFullSwipe: false) {
                Button {
                    tvm.deleteTask(task, from: group)
                    // main view update를 위한 task 개수 변화 감지
                    gvm.getGroups()
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
                
                Button {
                    taskToEdit = task
                    showEdit.toggle()
                } label: {
                    Image(systemName: "pencil")
                }
                .tint(.cyan)
            }
    }
}

extension View {
    func swipeActionModifier(group: Binding<Group>, task: Task, taskToEdit: Binding<Task?>, showEdit: Binding<Bool>) -> some View {
        modifier(SwipeActionModifier(group: group, task: task, taskToEdit: taskToEdit, showEdit: showEdit))
    }
}
