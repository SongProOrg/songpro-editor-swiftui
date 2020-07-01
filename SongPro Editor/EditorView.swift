//
//  EditorView.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import SwiftUI

struct EditorView: NSViewRepresentable {
    @Binding var text: String

    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.delegate = context.coordinator
        textView.string = text
        textView.autoresizingMask = [.width, .height]
        textView.font = NSFont(name: "Menlo", size: 16.0)!

        return textView
    }

    func updateNSView(_ textView: NSTextView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var editorView: EditorView

        init(_ editorView: EditorView) {
            self.editorView = editorView
        }

        func textDidChange(_ notification: Notification) {
            guard let text = notification.object as? NSText else {
                return
            }
            self.editorView.text = text.string
        }
    }
}

struct EditorView_PreviewContainer: View {
    @State var text = """
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

    var body: some View {
        EditorView(text: $text)
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditorView_PreviewContainer()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
            EditorView_PreviewContainer()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
