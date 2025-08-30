//
//  ContentView.swift
//  Graffiti App
//
//  Created by Sam Tan on 30/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Start")
                .font(.largeTitle)
                .bold()
            Text("Vandalising!")
                .font(.largeTitle)
                .bold()
            SwiftUIView()
                .fixedSize()
        }
        HStack {
            Button { //later we can let this button bring to antherview
                    } label: {
                        Text("Play Now")
                            .padding()
                            .background(.black)
                            .foregroundStyle(.white)
                            .cornerRadius(30)

                    }
        }
    }
}

#Preview {
    ContentView()
}
