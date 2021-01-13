//
//  Download.swift
//  SampleTunes
//
//  Created by leslie on 1/13/21.
//

import Foundation

class Download {
    
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var track: Track
    
    init(track: Track) {
        self.track = track
    }
}
