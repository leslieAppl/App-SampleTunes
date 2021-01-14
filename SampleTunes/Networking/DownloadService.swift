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
        guard let download = activeDownloads[track.previewURL] else { return }
        
        download.task?.cancel()
        activeDownloads[track.previewURL] = nil
    }
    
    func pauseDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        
        download.task?.cancel(byProducingResumeData: { (data) in
            download.resumeData = data
        })
        
        download.isDownloading = false
    }

    func resumeDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        }
        else {
            download.task = downloadsSession.downloadTask(with: download.track.previewURL)
        }
        
        // Starting download
        download.task?.resume()
        
        download.isDownloading = true
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
