//
//  MemoriesListView.swift
//  Unwind
//
//  Created by Sam Tan on 2/6/25.
//

import SwiftUI

class MemoriesViewModel: ObservableObject {
    @Published var memories: [Memory] = []
    
    private let saveKey = "savedMemories"
    
    init() {
        loadMemories()
    }
    func addMemory(image: UIImage, caption: String, date: Date) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert UIImage to data")
            return
        }
        let newMemory = Memory(id: UUID(), imageData: imageData, caption: caption, date: date)
        memories.append(newMemory)
        saveMemories()
    }
    func removeMemory(id: UUID) {
        memories.removeAll { $0.id == id }
        saveMemories()
    }

    
    private func saveMemories() {
        do {
            let data = try JSONEncoder().encode(memories)
            UserDefaults.standard.set(data, forKey: saveKey)
            print("Saved memories count: \(memories.count)")
        } catch {
            print("Error encoding memories: \(error.localizedDescription)")
        }
    }
    
    
    private func loadMemories() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            print("No saved data found")
            return
        }
        do {
            let decodedMemories = try JSONDecoder().decode([Memory].self, from: data)
            self.memories = decodedMemories
            print("Loaded memories count: \(memories.count)")
        } catch {
            print("Error decoding memories: \(error.localizedDescription)")
        }
    }
}

