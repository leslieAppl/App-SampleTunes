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

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
