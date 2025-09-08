//
//  DrawingOnlyView.swift
//  Graffiti App
//
//  Created by Chloe Lin on 8/9/25.
//

import SwiftUI

struct DrawingOnlyView: View {
    var lines: [Line]
    var backgroundImage: UIImage?
    var overlayImage: UIImage?

    var body: some View {
        GeometryReader { geo in
            ZStack {
                if let bgImage = backgroundImage {
                    Image(uiImage: bgImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                } else {
                    Color.white
                }

                if let overlay = overlayImage {
                    Image(uiImage: overlay)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width, height: geo.size.height)
                }

                ForEach(lines.indices, id: \.self) { i in
                    Path { path in
                        let line = lines[i]
                        if let first = line.points.first {
                            path.move(to: first)
                            for point in line.points.dropFirst() {
                                path.addLine(to: point)
                            }
                        }
                    }
                    .stroke(
                        lines[i].color,
                        style: StrokeStyle(lineWidth: lines[i].lineWidth, lineCap: .round, lineJoin: .round)
                    )
                }
            }
        }
    }
}
