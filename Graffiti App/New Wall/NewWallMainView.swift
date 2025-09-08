//
//  NewWallMainView.swift
//  Graffiti App
//
//  Created by Chloe Lin on 8/9/25.
//


import SwiftUI

struct NewWallMainView: View {
    var body: some View {
        ScrollView{
            NavigationView{
                VStack {
                    NavigationLink{
                        CameraMainView()
                    } label: {
                        Text ("Create")
                            .frame(width: 300, height: 60, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .font(.system(size: 50))
                        
                    }
                    Text("Previous Walls")
                        .font(.largeTitle)
                    
                }
            }
            .navigationTitle("")
        }
        
    }
}
#Preview {
    NewWallMainView()
}
