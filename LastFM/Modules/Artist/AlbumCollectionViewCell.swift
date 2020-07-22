//
//  AlbumCollectionViewCell.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/21/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumPlayedCountLabel: UILabel!
    
    private var imageUrl: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpAlbumImage()
        setUpLabels()
    }
    
    private func setUpAlbumImage() {
        albumImage.layer.cornerRadius = ArtistConstants.cornerRadius
    }
    
    private func setUpLabels() {
        setUpAlbumTitleLabel()
        setUpAlbumPlayedCountLabel()
    }
    
    private func setUpAlbumTitleLabel() {
        albumTitleLabel.textAlignment = .left
        albumTitleLabel.textColor = .black
        albumTitleLabel.numberOfLines = 1
    }
    
    private func setUpAlbumPlayedCountLabel() {
        albumPlayedCountLabel.textAlignment = .left
        albumPlayedCountLabel.textColor = .gray
        albumPlayedCountLabel.numberOfLines = 1
    }
    
    func configure(album: Album) {
        albumTitleLabel.text = album.name
        albumPlayedCountLabel.text = "(\(album.playcount) played)"
        configureAlbumImage(album: album)
    }
    
    private func configureAlbumImage(album: Album) {
        imageUrl = ""
        albumImage.image = nil
        if let urlString = album.image.filter({ $0.size == ImageSizesConstants.large.rawValue }).first?.text {
            imageUrl = urlString
            loadImage(imageUrl: urlString)
        }
    }
    
    private func loadImage(imageUrl: String) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            if self.imageUrl == imageUrl {
                DispatchQueue.main.async {
                    self.albumImage.image = image
                }
            }
        }
    }
}
