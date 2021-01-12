//
//  ViewController.swift
//  SampleTunes
//
//  Created by leslie on 1/12/21.
//

import AVFoundation
import AVKit
import UIKit

class SearchViewController: UIViewController {

    // MARK: - Constants
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let downloadService = DownloadService()
    let queryService = QueryService()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variable And Properties
    var searchResults: [Track] = []
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    // MARK: - Internal Methods
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    func playDownload(_ track: Track) {
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        
        let url = localFilePath(for: track.previewURL)
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    func position(for bar: UIBarPosition) -> UIBarPosition {
        return .topAttached
    }
    
    func reload(_ row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    
}

// MARK: - Table View Data Source
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate {
    
}

// MARK: - Track Cell Delegate
extension SearchViewController: TrackCellDelegate {
    func cancelTapped(_ cell: TrackCell) {
        
    }
    
    func downloadTapped(_ cell: TrackCell) {
        
    }
    
    func pauseTapped(_ cell: TrackCell) {
        
    }
    
    func resumeTapped(_ cell: TrackCell) {
        
    }
    
    
}
