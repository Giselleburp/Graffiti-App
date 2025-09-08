//
//  Infopage.swift
//  Graffiti App
//
//  Created by Sam Tan on 30/8/25.
//

import SwiftUI

struct Infopage: View {
    var body: some View {
        VStack(alignment:.leading) {
            Text("Singapore local")
                .font(.largeTitle)
            Text("GRAFFITI")
                .font(.largeTitle)
                .bold()
            Spacer()
            HStack {
                Text("Modern")
                    .font(.largeTitle)
                    .bold()
                Text("Graffiti")
                    .font(.largeTitle)
            }
                Text("• Hip-hop culture has a strong impact on Modern Graffiti.")
            Text("• some deem Graffiti as vandalisml, others appreciate Graffiti")
            Text("• we built this app so you won’t illegal stuff!!")
                .bold()
            Spacer()
            Text("kampong glam")
                .font(.largeTitle)
                .bold()
            Text("• many artists unite together by hand painting and spray painting unique arts")
            Text("• below is an artwork painted by the local artist, Yip Yew Chong")
            Spacer()
            Image(.downlaod)
                .frame(width:380, height:350)
                .clipped()
            Spacer()
            Spacer()
            Text("STRAITS TIME PHOTO: SHINTARO TAY")
        }
        .padding()
    }
}

#Preview {
    Infopage()
}
