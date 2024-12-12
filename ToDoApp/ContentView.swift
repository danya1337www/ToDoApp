//
//  ContentView.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 11.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .padding(30)
            Text("Favorite")
                .padding(-11)
            Spacer()
            Text("do it")
                .font(.largeTitle)
                .bold()
            Spacer()
            Button("Add") {
                print("Add")
            }
            .padding(30)
        }
        VStack {
            List {
                Text("do it")
                Text("do it")
                Text("do it")
                
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(20)
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
