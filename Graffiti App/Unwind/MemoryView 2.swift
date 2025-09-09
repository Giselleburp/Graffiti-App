//
//  MemoryView 2.swift
//  Unwind
//
//  Created by Sam Tan on 2/6/25.
//

import SwiftUI

struct MemoryView: View {
    @ObservedObject var viewModel: MemoriesViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    NavigationLink {
                        CameraMainView()
                    } label: {
                        Text("Add New Wall +")
                            .frame(width: 300, height: 60)
                            .background(Color.mint)
                            .cornerRadius(50)
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                    .padding(.top)
            if viewModel.memories.isEmpty {
                        UnavailView()
                    } else {
                        ForEach(viewModel.memories) { memory in
                            MemoryCardView(memory: memory) {
                                viewModel.removeMemory(id: memory.id)
                            }
                        }
                    }


                    NavigationLink {
                        PostMemoryView(viewModel: viewModel)
                    } label: {
                        Text("+")
                            .frame(width: 50, height: 50)
                            .background(Color.mint)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(25)
                    }
                    .padding(.bottom)
                }
                .padding()
            }
            .navigationTitle("Memories")
        }
    }
}


struct MemoryCardView: View {
    let memory: Memory
    var onDelete: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            memory.image
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(memory.caption)
                .font(.headline)

            Text(memory.date.formatted(date: .long, time: .shortened))
                .font(.subheadline)
                .foregroundColor(.secondary)


            if let onDelete = onDelete {
                Button(role: .destructive, action: onDelete) {
                    Label("Delete Memory", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

#Preview {
    MemoryView(viewModel: {
        let vm = MemoriesViewModel()
        
        let dummyImage = UIImage(systemName: "photo")!
        let imageData = dummyImage.jpegData(compressionQuality: 0.8)!
        
        vm.memories = [
            Memory(id: UUID(), imageData: imageData, caption: "Sample 1", date: Date()),
            Memory(id: UUID(), imageData: imageData, caption: "Sample 2", date: Date().addingTimeInterval(-86400))
        ]
        return vm
    }())
}
