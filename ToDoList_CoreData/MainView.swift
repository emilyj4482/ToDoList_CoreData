//
//  MainView.swift
//  ToDoList_CoreData
//
//  Created by EMILY on 2023/09/12.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Text("test commit from macbook")
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
