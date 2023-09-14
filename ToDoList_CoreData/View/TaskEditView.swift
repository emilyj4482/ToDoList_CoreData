//
//  TaskEditView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/14.
//

import SwiftUI

struct TaskEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = TaskViewModel()
    
    // task가 속한 group을 전달 받을 변수
    var group: Group
    // update 할 task를 전달 받을 변수
    @Binding var taskToEdit: Task?
    
    // create mode인지 edit mode인지 구분
    var isCreating: Bool = true
    
    // textfield
    @FocusState var focused: Bool
    @State var taskTitle: String = ""
    
    // textfield 입력값 없을 때 alert 호출
    @State var showAlert: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
                .foregroundColor(.red)
            TextField("Enter a task.", text: $taskTitle)
                .focused($focused)
                .onSubmit {
                    dismiss()
                }
            Spacer()
            Button {
                if taskTitle.trim().isEmpty {
                    showAlert = true
                } else if isCreating && !taskTitle.trim().isEmpty {
                    // create
                    vm.addTask(taskTitle, to: group)
                    dismiss()
                } else {
                    // edit
                    taskToEdit?.title = taskTitle
                    vm.updateTask(to: group)
                    dismiss()
                }
            } label: {
                Text("Done")
            }
            .alert("There must be at least 1 letter typed.", isPresented: $showAlert) {}
        }
        .padding(20)
        .frame(height: 50)
        .onAppear {
            focused = true
            // edit mode일 경우 기존 task title이 textfield에 입력된 상태
            if !isCreating {
                taskTitle = taskToEdit?.title ?? ""
            }
        }
    }
}
