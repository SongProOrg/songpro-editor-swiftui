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
    let html: String
    
    func makeNSView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.autoresizingMask = [.width, .height]
        view.loadHTMLString(html, baseURL: nil)
        return view
    }

    func updateNSView(_ view: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        HtmlView(html: "<h1>Song Title</h1>")
    }
}
