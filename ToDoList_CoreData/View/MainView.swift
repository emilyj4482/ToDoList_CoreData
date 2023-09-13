//
//  MainView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var vm: TodoViewModel
    
    @State private var showAddView: Bool = false
    
    /* group delete */
    // swipe action으로 delete button tap 시 확인하는 action sheet 호출
    @State private var showActionSheet: Bool = false
    // 잘못된 group 삭제 방지를 위해 실제 삭제 될 group을 담기 위한 빈 값
    @State private var itemToDelete: Group? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.groups) { group in
                        NavigationLink(value: group) {
                            HStack {
                                Image(systemName: "checklist.checked")
                                Text(group.name ?? "N/A")
                                Spacer()
                                Text("0")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            .padding([.top, .bottom], 5)
                            .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    itemToDelete = group
                                    showActionSheet = true
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .confirmationDialog("Are you sure deleting the list?", isPresented: $showActionSheet, titleVisibility: .visible) {
                    Button("Delete", role: .destructive) {
                        if let item = itemToDelete {
                            vm.deleteGroup(item)
                        }
                        itemToDelete = nil
                    }
                    
                    Button("Cancel", role: .cancel) {}
                }
                
                Text("You have 0 custom list.")
                    .font(.system(size: 13))
                    .foregroundColor(.mint)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.bottom, 5)
                
                Button {
                    showAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                    Text("New List")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.bottom, 5)

            }
            .navigationTitle("ToDoList")
            .sheet(isPresented: $showAddView) {
                NavigationStack {
                    AddNewListView()
                }
            }
            .navigationDestination(for: Group.self) { group in
                TodoListView(group: group)
            }
        }
    }
}
