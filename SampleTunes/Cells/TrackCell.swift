//
//  TrackCell.swift
//  SampleTunes
//
//  Created by leslie on 1/12/21.
//

import UIKit

// MARK: - Track Cell Delegate Protocol
protocol TrackCellDelegate {
    func cancelTapped(_ cell: TrackCell)
    func downloadTapped(_ cell: TrackCell)
    func pauseTapped(_ cell: TrackCell)
    func resumeTapped(_ cell: TrackCell)
}

// MARK: Track Cell
class TrackCell: UITableViewCell {

    // MARK: - Class Constants
    static let identifier = "TrackCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Variables And Properties
    var delegate: TrackCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: IBActions
    @IBAction func cancelTapped(_ sender: AnyObject) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
    
    @IBAction func pauseOrResumeTapped(_ sender: AnyObject) {
        if (pauseButton.titleLabel?.text == "Pause") {
            delegate?.pauseTapped(self)
        }
        else {
            delegate?.resumeTapped(self)
        }
    }
    
    // MARK: - Internal Methods
    func configure(track: Track, downloaded: Bool, download: Download?) {
        titleLabel.text = track.name
        artistLabel.text = track.artist
        
        // Show/hide download controls Pause/Resume, Cancel buttons, progress info.
        var showDownloadControls = false

        if let download = download {
            showDownloadControls = true
            let title = download.isDownloading ? "Pause" : "Resume"
            pauseButton.setTitle(title, for: .normal)
            
            progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
        }
        
        progressView.isHidden = !showDownloadControls
        progressLabel.isHidden = !showDownloadControls
        
        pauseButton.isHidden = !showDownloadControls
        cancelButton.isHidden = !showDownloadControls
        
        selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = downloaded || showDownloadControls
    }
    
    func updateDisplay(progress: Float, totalSize: String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }

}
