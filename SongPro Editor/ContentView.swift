//
//  ContentView.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    
    var body: some View {
        HStack {
            EditorView(text: $text)
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
            HtmlView(text: $text)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
