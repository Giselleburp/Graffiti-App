//
//  CameraMainView.swift
//  Graffiti App
//
//  Created by Sam Tan on 8/9/25.
//

import SwiftUI
import PhotosUI

struct CameraMainView: View {
    
    @State private var showingCamera = false
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                } else {
                    Text("No Image Selected")
                        .foregroundStyle(.gray)
                        .padding()
                }
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select Image")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .onChange(of: selectedItem) { newItem in
                    if let newItem = newItem {
                        Task {
                            if let data = try? await newItem.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                selectedImage = image
                            }
                        }
                    }
                }
                
                Button(action: {
                    showingCamera = true
                }) {
                    Text("Scan Wall")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(25)
                }
                .sheet(isPresented: $showingCamera) {
                    CameraView(image: $selectedImage)
                }
                
                
                if let selectedImage = selectedImage {
                    NavigationLink(destination: DrawingMainView(initialImage: selectedImage)) {
                        Text("GO!")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                }
            }
            .padding()
            .navigationTitle("")
        }
    }
    
}

#Preview {
    CameraMainView()
}

