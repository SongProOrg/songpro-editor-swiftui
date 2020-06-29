//
//  ContentView.swift
//  SongPro Again
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var song: String = "@title=Song Title"
    @State var html: String = "<h1>Song Title</h1>"
    
    var body: some View {
        HStack {
            EditorView(text: $song)
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
            HtmlView(html: $song)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
