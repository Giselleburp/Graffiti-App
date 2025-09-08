//
//  ContentView.swift
//  Graffiti App
//
//  Created by Sam Tan on 30/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNewItemSheetPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Information") {
                    isNewItemSheetPresented = true
                }
                .sheet(isPresented: $isNewItemSheetPresented) {
                    Infopage()
                }
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
                NavigationLink(destination: MemoryView()){
                    Text("Play now!")
                        .frame(width: 300, height: 60, alignment: .center)
                        .background(Color.mint)
                        .cornerRadius(50)
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
