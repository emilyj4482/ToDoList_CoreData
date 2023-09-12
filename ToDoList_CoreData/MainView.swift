//
//  MainView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var vm: TodoViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.groups) { group in
                        Text(group.name ?? "N/A")
                    }
                }
                
                Spacer()
                
                Text("You have 0 custom list.")
                    .font(.system(size: 13))
                    .foregroundColor(.mint)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.bottom, 5)
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                    Text("New List")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.bottom, 5)

            }
            .navigationTitle("ToDoList")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
