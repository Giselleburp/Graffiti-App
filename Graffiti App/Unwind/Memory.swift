//
//  Memory.swift
//  Graffiti App
//
//  Created by Chloe Lin on 8/9/25.
//

import SwiftUI

struct Memory: Identifiable, Codable {
    let id: UUID
    let imageData: Data
    let caption: String
    let date: Date

    var uiImage: UIImage? {
        UIImage(data: imageData)
    }

    var image: Image {
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "photo")
        }
    }
}
