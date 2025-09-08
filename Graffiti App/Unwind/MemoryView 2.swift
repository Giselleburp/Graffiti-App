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
                    if viewModel.memories.isEmpty {
                        UnavailView()
                    } else {
                        ForEach(viewModel.memories.indices, id: \.self) { index in
                            MemoryCardView(memory: viewModel.memories[index])
                        }
                    }
                }
                .navigationTitle("Canvas")
                .padding()
                NavigationLink(destination: CanvasView()){
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(Color.mint)
                        .cornerRadius(50)
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct MemoryCardView: View {
    let memory: Memory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            memory.pic
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(memory.caption)
                .font(.headline)
            
            Text(memory.date.formatted(date: .long, time: .shortened))
                .font(.subheadline)
                .foregroundColor(.secondary)
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
        vm.memories = [
            Memory(pic: Image(systemName: "photo"), caption: "Sample 1", date: Date()),
            Memory(pic: Image(systemName: "photo.fill"), caption: "Sample 2", date: Date().addingTimeInterval(-86400))
        ]
        return vm
    }())
}
