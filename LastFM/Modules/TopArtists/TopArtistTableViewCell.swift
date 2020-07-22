//
//  TopArtistTableViewCell.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class TopArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var listenersLabel: UILabel!
    
    private var imageUrl: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpLabels()
    }
    
    private func setUpLabels() {
        setUpArtistNameLabel()
        setUpListenersLabel()
    }
    
    private func setUpArtistNameLabel() {
        artistNameLabel.textAlignment = .left
        artistNameLabel.textColor = .black
        artistNameLabel.numberOfLines = 2
    }
    
    private func setUpListenersLabel() {
        listenersLabel.textAlignment = .left
        listenersLabel.textColor = .gray
        listenersLabel.numberOfLines = 1
    }
    
    func configure(artist: Artist) {
        artistNameLabel.text = artist.name
        listenersLabel.text = "(\(artist.listeners) listeners)"
        configureArtistImage(artist: artist)
    }
    
    private func configureArtistImage(artist: Artist) {
        imageUrl = ""
        artistImage.image = nil
        if let urlString = artist.image.filter({ $0.size == ImageSizesConstants.large.rawValue }).first?.text {
            imageUrl = urlString
            loadImage(imageUrl: urlString)
        }
    }
    
    private func loadImage(imageUrl: String) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            if self.imageUrl == imageUrl {
                DispatchQueue.main.async {
                    self.artistImage.image = image
                }
            }
        }
    }
}
