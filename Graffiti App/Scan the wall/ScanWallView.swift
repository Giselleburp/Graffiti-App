//
//  ScanWallView.swift
//  Graffiti App
//
//  Created by Sam Tan on 6/9/25.
//

import SwiftUI
import RealityKit

struct ScanWallView : View {

    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
   
    }

}
struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let anchor = AnchorEntity(plane: .horizontal)
//        let material = SimpleMaterial(color: .clear, isMetallic: true)
        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.03))
       anchor.addChild(box)
        arView.scene.anchors.append(anchor)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
}
#if DEBUG
struct ScanWallView_Previews: PreviewProvider {
    static var previews: some View {
        ScanWallView()
    }
}
#endif
