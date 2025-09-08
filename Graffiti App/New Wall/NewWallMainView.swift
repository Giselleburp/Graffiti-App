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
                        WallView()
                    } label: {
                        Text ("Create")
                            .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: 50))
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 70))
                        
                    }
                    Text("Previous Walls")
                        .font(.largeTitle)
                        
                        
                    Spacer()
                    
                }
            }
            .navigationTitle("")
        }
        
    }
}
#Preview {
    NewWallMainView()
}
