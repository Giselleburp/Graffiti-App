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
                   UnavailView()
                } else {
                    List {
                        ForEach(viewModel.memories.indices, id: \.self) { index in
                            let memory = viewModel.memories[index]
                            VStack(alignment: .leading) {
                                memory.pic
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
                            .padding(.vertical, 5)
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
            }
            .navigationTitle("Memories")
        }
    }
