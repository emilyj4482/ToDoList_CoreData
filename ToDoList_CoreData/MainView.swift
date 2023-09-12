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
                    Text("test commit from mac mini")
                }
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
