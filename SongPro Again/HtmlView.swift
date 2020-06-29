//
//  PreviewView.swift
//  SongPro Again
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import SwiftUI
import WebKit

struct HtmlView: NSViewRepresentable {
    @Binding var text: String
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.autoresizingMask = [.width, .height]
        webView.loadHTMLString(text, baseURL: nil)
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        let songPro = SongPro()
        let song = songPro.parse(text: text)
        var html = ""
        if song.title != nil {
            html += "<h1>" + song.title! + "</h1>"
        }
        
        if song.artist != nil {
            html += "<h2>" + song.artist! + "</h2>"
        }
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

//struct HtmlView_Previews: PreviewProvider {
//    static var previews: some View {
//        HtmlView(html: "<h1>Song Title</h1>")
//    }
//}
