//
//  ContentView.swift
//  Flips
//
//  Created by Leonid Lavrov on 27.01.2021.
//

import SwiftUI

let defaultTaskName = ""

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var newTaskName = defaultTaskName
    
    var searchBar: some View {
        HStack {
            TextField("Enter task", text: self.$newTaskName)
            Button(action: self.addTask, label: {
                Text("Add")
            }).disabled(self.newTaskName.isEmpty)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar.padding()
                
                List() {
                    ForEach(self.taskStore.tasks) {
                        task in Text(task.name)
                    }
                    .onMove(perform: taskStore.move)
                    .onDelete(perform: taskStore.remove)
                }.navigationTitle("Tasks")
                .navigationBarItems(trailing: EditButton().disabled(taskStore.tasks.isEmpty) )
            }
        }
    }
    
    func addTask() {
        taskStore.add(name: self.newTaskName)
        self.newTaskName = defaultTaskName
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
