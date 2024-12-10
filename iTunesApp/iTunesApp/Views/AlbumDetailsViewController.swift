//
//  AlbumDetailsViewController.swift
//  iTunesApp
//
//  Created by Guru Prasad on 09/12/24.
//

import UIKit
import AVKit

class AlbumDetailsViewController: UIViewController {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var artistLable: UILabel!
    @IBOutlet weak var albumTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var previewImage: UIView!
    
    var album: ItunsListResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumImage.downloaded(from: album?.artworkUrl100 ?? "")
        titleLable.text = album?.trackName ?? ""
        artistLable.text = album?.artistName ?? ""
        if let albumType = album?.kind {
            albumTypeLabel.text = albumType.capitalized
        }
        descriptionLabel.text = album?.collectionCensoredName ?? ""
        if let url = album?.previewUrl {
            let player = AVPlayer(url: URL(string: url)!)
            let playerController = AVPlayerViewController()
            playerController.player = player
            self.addChild(playerController)
            previewImage.addSubview(playerController.view)
            playerController.view.frame = previewImage.frame
            player.play()
        }
        
    }
    
}
