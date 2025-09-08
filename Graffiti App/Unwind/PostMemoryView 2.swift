//
//  PostMemoryView 2.swift
//  Unwind
//
//  Created by Sam Tan on 2/6/25.
//


import SwiftUI
import PhotosUI



struct PostMemoryView: View {
    @ObservedObject var viewModel: MemoriesViewModel

    @State private var caption = ""
    @State private var wakeUp = Date.now
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var uiImage: UIImage? = nil
    @State private var goToNextView = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if let selectedImage = selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Text("No image selected")
                    }

                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Select a photo", systemImage: "photo")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
let loadedUIImage = UIImage(data: data) {
                                uiImage = loadedUIImage
                                selectedImage = Image(uiImage: loadedUIImage)
                            }
                        }
                    }
                }

                Section {
                    TextField("Enter caption here", text: $caption)
                    DatePicker("Enter a date", selection: $wakeUp)
                }

                Section {
                    Button {
                        saveMemory()
                        goToNextView = true
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Save Memory")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.mint)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Post Canvas")
            .navigationDestination(isPresented: $goToNextView) {
                MemoryView(viewModel: viewModel)
            }
        }
    }

    func saveMemory() {
        guard let uiImage = uiImage else { return }
        let memoryImage = Image(uiImage: uiImage)
        let newMemory = Memory(pic: memoryImage, caption: caption, date: wakeUp)
        viewModel.addMemory(newMemory)
    }
}

#Preview {
    PostMemoryView(viewModel: MemoriesViewModel())
}
