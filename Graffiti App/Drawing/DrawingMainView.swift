//
//  DrawingMainView.swift
//  Graffiti App
//
//  Created by Chloe Lin on 8/9/25.
//

import SwiftUI
import PhotosUI

struct DrawingMainView: View {
    @State private var lines: [Line] = []
    @State private var undoneLines: [Line] = []
    @State private var selectedColor: Color = .black
    @State private var lineWidth: CGFloat = 5
    @State private var isEraserOn = false
    @State private var showingSaveAlert = false
    @State private var selectedImage: UIImage?
    @State private var imageOffset: CGSize = .zero
    @State private var showingImagePicker = false
    @State private var imageScale: CGFloat = 1.0

    
    var body: some View {
        VStack {
            DrawingPad(
                lines: $lines,
                undoneLines: $undoneLines,
                selectedColor: $selectedColor,
                lineWidth: $lineWidth,
                isEraserOn: $isEraserOn,
                selectedImage: $selectedImage,
                imageOffset: $imageOffset,
                imageScale: $imageScale
            )

            
            Toolbar(
                selectedColor: $selectedColor,
                lineWidth: $lineWidth,
                isEraserOn: $isEraserOn,
                lines: $lines,
                undoneLines: $undoneLines,
                showingImagePicker: $showingImagePicker,
                selectedImage: $selectedImage,      // <-- Pass this binding here
                onSave: save,
                showingSaveAlert: $showingSaveAlert
            )

            .padding()
        }
        .alert("Saved to Photos!", isPresented: $showingSaveAlert) {
            Button("OK", role: .cancel) {}
        }
       
        .sheet(isPresented: $showingImagePicker) {
            
            PhotoPicker(selectedImage: $selectedImage)
        }
    }
    struct PhotoPicker: UIViewControllerRepresentable {
        @Binding var selectedImage: UIImage?
        
        func makeUIViewController(context: Context) -> PHPickerViewController {
            var config = PHPickerConfiguration()
            config.filter = .images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, PHPickerViewControllerDelegate {
            let parent: PhotoPicker
            
            init(_ parent: PhotoPicker) {
                self.parent = parent
            }
            
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                picker.dismiss(animated: true)
                
                guard let itemProvider = results.first?.itemProvider,
                      itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
                
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        self?.parent.selectedImage = image as? UIImage
                    }
                }
            }
        }
    }
    private func save() {
        let image = snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        showingSaveAlert = true
    }
    
    private func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: DrawingOnlyView(lines: lines))
        let view = controller.view!
        let targetSize = UIScreen.main.bounds.size
        
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
    private func removeImage() {
        selectedImage = nil
        imageOffset = .zero
        imageScale = 1.0
    }

}

struct DrawingMainView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingMainView()
    }
}
