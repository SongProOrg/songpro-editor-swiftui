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
    static var text = """
@title=Escape Capsule
@artist=Brian Kelly
!bandcamp=https://spilth.bandcamp.com/track/escape-capsule

# Verse 1

Climb a-[D]board [A]
I've been [Bm]waiting for you [F#m]
Climb a-[G]board [D]
You'll be [Asus4]safe in [A7]here

# Chorus 1

[G] I'm a [D]rocket [F#]made for your pro-[Bm]tection
You're [G]safe with me, un-[A]til you leave

# Solo

| [Em] | [D] | [Em] | [D] |
| [Em] | [D] | [Em] | [F#] |
| [B] | [B] | [Bm] | [Bm] |
"""
    
    static var previews: some View {
        Group {
            ContentView(text: text)
                .previewLayout(PreviewLayout.fixed(width: 800, height: 600))
                .environment(\.colorScheme, .light)
            .   previewDisplayName("Light Mode")
            ContentView(text: text)
                .environment(\.colorScheme, .dark)
                .previewLayout(PreviewLayout.fixed(width: 800, height: 600))
                .previewDisplayName("Dark Mode")
        }
        
    }
}
