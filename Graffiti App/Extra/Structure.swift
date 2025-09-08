//
//  Structure.swift
//  Graffiti App
//
//  Created by Sam Tan on 8/9/25.
//

import SwiftUI
import Foundation

struct Memory {
    var pic: Image
    var caption: String
    var date: Date
}

struct SavedMemory: Codable {
    var caption: String
    var date: Date
}
