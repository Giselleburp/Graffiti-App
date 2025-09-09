//
//  CanvasSnapShotView.swift
//  Graffiti App
//
//  Created by Chloe Lin on 8/9/25.
//

import SwiftUI

struct CanvasSnapshotView: View {
    var lines: [Line]
    var backgroundImage: UIImage?
    var overlayImage: UIImage?
    var imageScale: CGFloat
    var imageOffset: CGSize
    var isImageLocked: Bool

    var body: some View {
        DrawingOnlyView(
            lines: lines,
            backgroundImage: backgroundImage,
            overlayImage: overlayImage,
            imageScale: imageScale,
            imageOffset: imageOffset,
            isImageLocked: isImageLocked
        )
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
    }
}
