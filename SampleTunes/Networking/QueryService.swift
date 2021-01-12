//
//  QueryService.swift
//  SampleTunes
//
//  Created by leslie on 1/12/21.
//

import Foundation

///Runs query data task, and stroes results in array of Tracks
class QueryService {
    
    // MARK: - Constants
    
    // MARK: - Variables And Properties
    var errorMessage = ""
    var tracks: [Track] = []
    
    // MARK: - Type Alias
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> Void
    
    // MARK: - Internal Methods
    private func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        tracks.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any]
        else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        var index = 0
        
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
               let previewURLString = trackDictionary["previewUrl"] as? String,
               let previewURL = URL(string: previewURLString),
               let name = trackDictionary["trackName"] as? String,
               let artist = trackDictionary["artistName"] as? String {
                tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
                index += 1
            }
            else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
}
