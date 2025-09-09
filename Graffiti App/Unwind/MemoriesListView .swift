//
//  MemoriesListView 2.swift
//  Unwind
//
//  Created by Sam Tan on 2/6/25.
//


import SwiftUI

struct MemoriesListView: View {
    @StateObject var viewModel = MemoriesViewModel()
    @State private var showPostMemory = false

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.memories.isEmpty {
                    Text("No memories yet")
                } else {
                    List(viewModel.memories) { memory in
                        VStack(alignment: .leading) {
                            memory.image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            Text(memory.caption)
                                .font(.headline)

                            Text(memory.date.formatted(date: .long, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .listStyle(.plain)
                }

                Button("Post New Memory") {
                    showPostMemory = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $showPostMemory) {
                    PostMemoryView(viewModel: viewModel)
                }
            }
            .navigationTitle("Memories")
        }
    }
}
