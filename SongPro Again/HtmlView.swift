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
    @Binding var html: String
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.autoresizingMask = [.width, .height]
        webView.loadHTMLString(html, baseURL: nil)
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
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
