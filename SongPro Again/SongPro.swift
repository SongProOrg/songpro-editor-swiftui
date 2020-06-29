//
//  SongPro.swift
//  SongPro Again
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

struct SongPro {
    init() {
        
    }
    
    func parse(text: String) -> Song {
        var song = Song()
        
        let lines: [Substring] = text.split(separator: "\n")

        for line in lines {
            if (line.starts(with: "@")) {
                var key: String?
                var value: String?

                let regex = try! NSRegularExpression(pattern: "@(\\w*)=([^%]*)")
                if let match = regex.firstMatch(in: String(line), options: [], range: NSRange(location: 0, length: line.utf16.count)) {
                  if let keyRange = Range(match.range(at: 1), in: line) {
                    key = String(line[keyRange]).trimmingCharacters(in: .whitespacesAndNewlines)
                  }

                  if let valueRange = Range(match.range(at: 2), in: line) {
                    value = String(line[valueRange]).trimmingCharacters(in: .whitespacesAndNewlines)
                  }
                }
                
                switch key {
                    case "title":
                        song.title = value!
                    case "artist":
                        song.artist = value!
                    case "capo":
                        song.capo = value!
                    case "key":
                        song.key = value!
                    case "tempo":
                        song.tempo = value!
                    case "year":
                        song.year = value!
                    case "album":
                        song.capo = value!
                    case "tuning":
                        song.capo = value!
                    default:
                        break
                }
            }
        }
        
        return song
    }
}
