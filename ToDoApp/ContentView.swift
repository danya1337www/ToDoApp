//
//  ContentView.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 11.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                let tasks = ["1", "2", "3"]
                List {
                    ForEach(tasks, id:\.self) { task in
                        Text(task)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("to do")
                }
            }
            .toolbar {
                Button("Add") {
                    print("Add tapped")
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
