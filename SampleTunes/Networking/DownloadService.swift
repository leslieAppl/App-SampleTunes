//
//  DownloadService.swift
//  SampleTunes
//
//  Created by leslie on 1/12/21.
//

import Foundation

/// Downloads song snippets, and stores in local file.
/// Allows cancel, pause, resume download.

class DownloadService {
    
    // MARK: - Variables And Properties
    var activeDownloads: [URL: Download] = [:]
    var downloadsSession: URLSession!
    
    // MARK: - Internal Methods
    func cancelDownload(_ track: Track) {
        
    }
    
    func pauseDownload(_ track: Track) {
        
    }

    func resumeDownload(_ track: Track) {
        
    }

    // TODO: URLSession Download Task
    func startDownload(_ track: Track) {
        let download = Download(track: track)
        download.task = downloadsSession.downloadTask(with: track.previewURL)
        // Start the download task by calling resume() on it.
        download.task?.resume()
        download.isDownloading = true
        activeDownloads[download.track.previewURL] = download
    }

}
