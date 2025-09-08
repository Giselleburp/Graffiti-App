//
//  DrawingPad.swift
//  Graffiti App
//
//  Created by Chloe Lin on 8/9/25.
//

import SwiftUI

struct DrawingPad: View {
    @Binding var lines: [Line]
    @Binding var undoneLines: [Line]
    @Binding var selectedColor: Color
    @Binding var lineWidth: CGFloat
    @Binding var isEraserOn: Bool

    let backgroundImage: UIImage?
    @Binding var overlayImage: UIImage?       
    @Binding var imageOffset: CGSize
    @Binding var imageScale: CGFloat
    @Binding var isImageLocked: Bool

    @State private var currentLine = Line(points: [], color: .black, lineWidth: 5)
    @GestureState private var gestureScale: CGFloat = 1.0
    @GestureState private var dragOffset: CGSize = .zero

    func erase(at point: CGPoint, threshold: CGFloat = 20) {
        lines.removeAll { line in
            line.points.contains { p in
                let dx = p.x - point.x
                let dy = p.y - point.y
                return sqrt(dx * dx + dy * dy) < threshold
            }
        }
    }

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white // background
                
                if let bgImage = backgroundImage {
                    Image(uiImage: bgImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }


                if let overlay = overlayImage {
                    if isImageLocked {
                        Image(uiImage: overlay)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        Image(uiImage: overlay)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(imageScale * gestureScale)
                            .offset(
                                x: imageOffset.width + dragOffset.width,
                                y: imageOffset.height + dragOffset.height
                            )
                            .gesture(
                                SimultaneousGesture(
                                    DragGesture()
                                        .updating($dragOffset) { value, state, _ in
                                            state = value.translation
                                        }
                                        .onEnded { value in
                                            imageOffset.width += value.translation.width
                                            imageOffset.height += value.translation.height
                                        },
                                    MagnificationGesture()
                                        .updating($gestureScale) { value, state, _ in
                                            state = value
                                        }
                                        .onEnded { value in
                                            imageScale *= value
                                        }
                                )
                            )
                    }
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
                    .stroke(lines[i].color, style: StrokeStyle(
                        lineWidth: lines[i].lineWidth,
                        lineCap: .square,
                        lineJoin: .bevel
                    ))
                }
                

                Path { path in
                    if let first = currentLine.points.first {
                        path.move(to: first)
                        for point in currentLine.points.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                }
                .stroke(currentLine.color, style: StrokeStyle(
                    lineWidth: currentLine.lineWidth,
                    lineCap: .square,
                    lineJoin: .bevel
                ))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped() // <- this is the key line that keeps content inside canvas
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if isEraserOn {
                            erase(at: value.location)
                        } else {
                            currentLine.color = selectedColor
                            currentLine.lineWidth = lineWidth
                            currentLine.points.append(value.location)
                        }
                    }
                    .onEnded { _ in
                        if !isEraserOn {
                            lines.append(currentLine)
                            currentLine = Line(points: [], color: selectedColor, lineWidth: lineWidth)
                            undoneLines.removeAll()
                        }
                    }
                )
        }
    }
}
