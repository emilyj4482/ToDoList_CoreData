//
//  TaskHStack.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/14.
//

import SwiftUI

struct TaskHStack: View {
    
    @ObservedObject var vm = TaskViewModel()
    
    @State var task: Task
    var group: Group
    
    var body: some View {
        HStack {
            Image(systemName: task.isDone ? "checkmark.circle" : "circle")
                .foregroundColor(task.isDone ? .green : .red)
                .onTapGesture {
                    task.isDone.toggle()
                    vm.updateTask(to: group)
                    print(task)
                }
            Text(task.title ?? "N/A")
            Spacer()
            Image(systemName: task.isImportant ? "star.fill": "star")
                .foregroundColor(.yellow)
                .onTapGesture {
                    task.isImportant.toggle()
                    vm.updateTask(to: group)
                    print(task)
                }
        }
        .padding([.top, .bottom], 5)
    }
}
