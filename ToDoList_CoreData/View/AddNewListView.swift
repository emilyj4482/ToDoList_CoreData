//
//  AddNewListView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/13.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: GroupViewModel
    
    /* textfield */
    @State var listName: String = ""
    @FocusState var focused: Bool
    
    // 입력값 Important일 때 alert 호출
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            TextField("Untitled List", text: $listName)
                .focused($focused)
                .font(.system(.largeTitle, weight: .bold))
                .padding(.leading, 20)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // "Important" list name 금지
                    if getListName(listName) == "Important" {
                        showAlert = true
                    } else {
                        vm.addGroup(examListName(getListName(listName)))
                        dismiss()
                    }
                } label: {
                    Text("Done")
                }
                .alert("You cannot name a list \"Important\"", isPresented: $showAlert) {}
            }
        }
        // 화면이 뜨자마자 텍스트필드 입력 모드
        .onAppear{
            self.focused = true
        }
    }
    
    // textfield 입력값 공백 시 "Untitled list" 부여
    func getListName(_ listName: String) -> String {
        if listName.trim().isEmpty {
            return "Untitled list"
        }
        return listName.trim()
    }
    
    // group name 중복검사
    func examListName(_ text: String) -> String {
        let list = vm.groups.map { group in
            group.name ?? ""
        }
        
        var count = 1
        var listName = text
        while list.contains(listName) {
            listName = "\(text) (\(count))"
            count += 1
        }
        
        return listName
    }
}
