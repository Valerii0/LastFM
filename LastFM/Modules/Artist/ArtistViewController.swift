//
//  ArtistViewController.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController, Storyboarded {
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    
    var presenter: ArtistPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.loadAlbums()
    }
    
    private func setUpUI() {
        setUpView()
        setUpAlbumsCollectionView()
    }
    
    private func setUpView() {
        self.navigationItem.title = presenter.title
    }
    
    private func setUpAlbumsCollectionView() {
        albumsCollectionView.layoutIfNeeded()
        let insert: CGFloat = ArtistConstants.indentWith
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: insert, left: insert, bottom: insert, right: insert)
        layout.minimumLineSpacing = insert
        layout.minimumInteritemSpacing = insert
        albumsCollectionView.collectionViewLayout = layout
        albumsCollectionView.backgroundColor = .clear
        albumsCollectionView.register(UINib(nibName: ArtistConstants.albumCollectionViewCell.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: ArtistConstants.albumCollectionViewCell.rawValue)
        albumsCollectionView.delegate = self
        albumsCollectionView.dataSource = self
    }

}

extension ArtistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.albumsToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistConstants.albumCollectionViewCell.rawValue, for: indexPath) as! AlbumCollectionViewCell
        cell.configure(album: presenter.albumsToShow[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (CGFloat(ArtistConstants.countCellPerRow + 1) * ArtistConstants.indentWith)) / CGFloat(ArtistConstants.countCellPerRow)
        let height: CGFloat = width * 1.5
        return CGSize(width: width, height: height)
    }
}

extension ArtistViewController: ArtistView {
    func reloadInfo() {
        DispatchQueue.main.async {
            self.albumsCollectionView.reloadData()
        }
    }
}
