//
//  ContentView.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 11.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks = ["1", "2", "3"]
    @State private var isShowingAddSheet = false
    @State private var newTask = ""
    
    
    
    var body: some View {
        NavigationView{
            VStack {
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        isShowingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                VStack {
                    Text("New grind")
                        .font(.headline)
                        .padding()
                    TextField("Task name", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Save") {
                        if !newTask.isEmpty {
                            tasks.append(newTask)
                            newTask = ""
                            isShowingAddSheet = false
                        }
                    }
                    .padding()
                    Spacer()
                }
                .padding()
            }
        }
    }
}



#Preview {
    ContentView()
}
