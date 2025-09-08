//
//  UnavailView.swift
//  Graffiti App
//
//  Created by Sam Tan on 6/9/25.
//

import SwiftUI

struct UnavailView: View {
    var body: some View {
        NavigationStack {
            Image(systemName: "swift")
                .foregroundStyle(Color.gray)
                .font(.system(size: 40))
            Text("No graffiti yet")
                .font(.system(size: 22))
                .bold()
            Text("You have not saved any Canvas yet")
                .font(.system(size: 15))
                .foregroundStyle(Color.gray)
            NavigationLink(destination: PostMemoryView()) {
                Text("Create new canvas")
                    .font(.subheadline)
                    .frame(width: 150, height: 25, alignment: .center)
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .bold()
            }
        }
    }
}

#Preview {
    UnavailView()
}
