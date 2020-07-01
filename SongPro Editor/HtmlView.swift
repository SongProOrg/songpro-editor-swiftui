//
//  PreviewView.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import SwiftUI
import WebKit
import SongPro

struct HtmlView: NSViewRepresentable {
    @Binding var text: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.autoresizingMask = [.width, .height]
        webView.loadHTMLString(text, baseURL: nil)
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        let song = SongPro.parse(text)
        let html = buildHtml(song: song)

        webView.loadHTMLString(html, baseURL: nil)
    }

    private func buildHtml(song: Song) -> String {
        var html = """
                   <!DOCTYPE html>
                   <html lang="en">
                   <head>
                     <meta charset="utf-8">
                     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha256-eSi1q2PG6J7g7ib17yAaWMcrr5GrtohYChqibrV7PBE=" crossorigin="anonymous"/>
                   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" integrity="sha256-PF6MatZtiJ8/c9O9HQ8uSUXr++R9KBYu4gbNG5511WE=" crossorigin="anonymous"/>
                   <style>
                   h1.title {
                     text-align: center;
                     font-weight: 900; }

                   h2.artist {
                     text-align: center; }

                   #chords {
                     margin-bottom: 1em;
                     text-align: center; }

                   .section {
                     display: -webkit-box;
                     display: -ms-flexbox;
                     display: flex;
                     -webkit-box-orient: horizontal;
                     -webkit-box-direction: normal;
                         -ms-flex-direction: row;
                             flex-direction: row;
                     margin-bottom: 1.0em; }
                     .section .name {
                       width: 12%;
                       font-family: "Times New Roman", serif;
                       font-weight: bold;
                       font-size: 1.2rem;
                       font-style: italic; }

                   .information {
                     float: right;
                     max-width: 100px;
                     text-align: right; }

                   @media screen and (max-width: 768px) {
                     .section {
                       -webkit-box-orient: vertical;
                       -webkit-box-direction: normal;
                           -ms-flex-direction: column;
                               flex-direction: column; }
                       .section .name {
                         width: 100%; }
                     .information {
                       float: none;
                       text-align: right;
                       max-width: 768px; }
                     .year {
                       display: none; }
                     .album {
                       display: none; } }

                   .line {
                     display: -webkit-box;
                     display: -ms-flexbox;
                     display: flex;
                     -ms-flex-wrap: wrap;
                         flex-wrap: wrap;
                     -webkit-box-align: end;
                         -ms-flex-align: end;
                             align-items: flex-end; }

                   .tablature {
                     font-family: monospace;
                     font-size: 1.3rem;
                     line-height: 1.0rem;
                     overflow: visible;
                     white-space: nowrap; }

                   .comment {
                     font-style: italic;
                     font-size: 0.5rem;
                     color: #333;
                     background: #eee;
                     padding: 0.1em 0.25em;
                     border-radius: 4px; }

                   .measures {
                     display: -webkit-box;
                     display: -ms-flexbox;
                     display: flex;
                     -ms-flex-wrap: wrap;
                         flex-wrap: wrap;
                     max-width: 48em; }

                   .measure {
                     width: 12em;
                     display: -webkit-box;
                     display: -ms-flexbox;
                     display: flex;
                     border-left: 2px solid #000;
                     border-right: 2px solid #000;
                     padding-left: 0.5em;
                     padding-right: 0.5em;
                     margin-left: -2px;
                     margin-bottom: 1.4em; }
                     .measure .chord {
                       width: 8em;
                       -webkit-box-flex: 1;
                           -ms-flex-positive: 1;
                               flex-grow: 1; }

                   .chord, .lyric {
                     text-wrap: avoid;
                     margin-right: 0.3em; }

                   .chord {
                     min-height: 1.4em;
                     font-weight: bold;
                     font-size: 1.1rem;
                     margin-bottom: -0.2em; }

                   .lyric {
                     min-height: 1.5em;
                     font-family: "Times New Roman", serif;
                     font-size: 1.4rem; }

                   .comment {
                     font-family: "Times New Roman";
                     font-size: 1.4rem;
                     font-style: italic;
                     margin-bottom: 0.5em; }

                   </style>
                   </head>
                   <body>
                   <div class="container mb-4">
                   """

        if song.title != nil {
            html += "<h1 class=\"title\">" + song.title! + "</h1>"
        }

        if song.artist != nil {
            html += "<h2 class=\"artist\">" + song.artist! + "</h2>"
        }

        song.sections.forEach { section in
            html += "<div class=\"section\">"
            if section.name != nil {
                html += "<div class=\"name\">" + section.name! + "</div>"
            }
            html += "<div class=\"lines\">"
            section.lines.forEach { (line) in
                html += "<div class=\"line\">"
                line.parts.forEach { (part) in
                    html += "<div class=\"part\"><div class=\"chord\">\(part.chord!)</div><div class=\"lyric\">\(part.lyric!)</div></div>"
                }
                html += "</div>"
            }
            html += "</div>"
            html += "</div>"
        }

        html += "</body></html>"

        return html
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

struct HtmlView_PreviewContainer: View {
    @State var text = previewSong

    var body: some View {
        HtmlView(text: $text)
    }
}

struct HtmlView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HtmlView_PreviewContainer()
                    .environment(\.colorScheme, .light)
                    .previewDisplayName("Light Mode")
            HtmlView_PreviewContainer()
                    .environment(\.colorScheme, .dark)
                    .previewDisplayName("Dark Mode")
        }
    }
}
