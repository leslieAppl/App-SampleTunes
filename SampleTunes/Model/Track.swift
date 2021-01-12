//
//  Track.swift
//  SampleTunes
//
//  Created by leslie on 1/12/21.
//

import Foundation.NSURL

/// Query servie creates Track objects
class Track {
    
    // MARK: - Constants
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    
    // MARK: - Variables And Properties
    var downloaded = false
    
    // MARK: - Initialization
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
}
