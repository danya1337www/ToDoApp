//
//  ContentView.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 11.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks = ["Learn iOS Dev", "Make Money", "Live Life"]
    @State private var isShowingAddSheet = false
    @State private var newTask = ""
    
    
    
    var body: some View {
        NavigationView{
            VStack {
                if tasks.isEmpty {
                    Text("empty")
                } else {
                    List {
                        ForEach(tasks, id:\.self) { task in
                            Text(task)
                        }
                        .onDelete(perform: deleteTask)
                    }
                }
               
            }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("workin'")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action : {
                            isShowingAddSheet = true
                        }) {
                            Image(systemName: "plus")
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
        private func deleteTask(at offsets: IndexSet) {
            tasks.remove(atOffsets: offsets)
        }
    }



#Preview {
    ContentView()
}
