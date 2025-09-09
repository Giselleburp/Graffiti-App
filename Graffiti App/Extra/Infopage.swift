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
            Text("")
            Text("Singapore local Graffiti")
                .font(.largeTitle)
                .bold()
                Text("• Hip-hop strongly impact Modern Graffiti.")
                Text("• some think its Vandalism, some appreciate.")
                Text("• we built this app so you won’t do illegal stuff")
                Text("kampong glam")
                    .font(.largeTitle)
                    .bold()
                Text("• many artists unite together by hand painting and spray")
                Text("painting unique arts")
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
