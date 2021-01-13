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
    let defaultSession = URLSession(configuration: .default)
    
    // MARK: - Variables And Properties
    /// The data task will be re-initialized each tiem the user enters a new search string.
    var dataTask: URLSessionTask?
    
    var errorMessage = ""
    var tracks: [Track] = []
    
    // MARK: - Type Alias
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> Void
    
    // MARK: - Internal Methods
    // TODO: URLSession Data Task
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
//            print(urlComponents)
            urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
//            print(urlComponents)
            guard let url = urlComponents.url else { return }
//            print(url)
            dataTask = defaultSession.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                
                defer {
                    self?.dataTask = nil
//                    print("defer")
                }
                
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    self?.updateSearchResults(data)
                    
                    DispatchQueue.main.async {
                        completion(self?.tracks, self?.errorMessage ?? "")
                    }
                }
            })
            
        }
        
        dataTask?.resume()
//        print("resume")
    }
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
