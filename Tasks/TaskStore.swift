//
//  DataStore.swift
//  Flips
//
//  Created by Leonid Lavrov on 30.01.2021.
//

import Foundation
import SwiftUI
import Combine

struct Task: Identifiable {
    var id = UUID()
    var name = String()
}

class TaskStore: ObservableObject {
    @Published var tasks = Array<Task>()
    @Published var hasTasks: Bool = false
    
    init() {
        hasTasks = !tasks.isEmpty
    }
    
    func add(name: String) {
        if !(self.hasTask(name: name)) {
            tasks.append(Task(name: name))
        }
    }
    
    func remove(offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func move(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func hasTask(name: String) -> Bool {
        return tasks.contains(where: { task in task.name == name })
    }
}
