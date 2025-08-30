//
//  ColorPickerView.swift
//  Graffiti App
//
//  Created by Sam Tan on 30/8/25.
//

import SwiftUI

struct ColorPickerView: View {
    let colors = [Color.red, Color.orange, Color.yellow, Color.blue, Color.purple, Color.green]
    @Binding var selectedColor: Color
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.blue))
    }
}
