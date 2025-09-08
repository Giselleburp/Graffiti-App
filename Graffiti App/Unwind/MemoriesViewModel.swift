//
//  MemoriesListView.swift
//  Unwind
//
//  Created by Sam Tan on 2/6/25.
//

import SwiftUI

struct SavedMemory: Codable {
    var caption: String
    var date: Date
}

class MemoriesViewModel: ObservableObject {
    @Published var memories: [Memory] = []

    private let saveKey = "savedMemories"

    init() {
        loadMemories()
    }

    func addMemory(_ memory: Memory) {
        memories.append(memory)
        saveMemories()
    }

    func saveMemories() {
        let saveData = memories.map {
            SavedMemory(caption: $0.caption, date: $0.date)
        }

        if let encoded = try? JSONEncoder().encode(saveData) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func loadMemories() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([SavedMemory].self, from: savedData) {
            memories = decoded.map {
                Memory(pic: Image(systemName: "photo"), caption: $0.caption, date: $0.date)
            }
        }
    }
}
