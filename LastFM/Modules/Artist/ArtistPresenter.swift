//
//  ArtistPresenter.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol ArtistView: class {
    func reloadInfo()
}

class ArtistPresenter {
    private weak var view: ArtistView?
    private var coordinator: MainCoordinator?
    private var artist: Artist
    private var albums = [Album]()
    var albumsToShow: [Album] {
        return albums
    }
    var title: String {
        return artist.name
    }
    
    init(view: ArtistView, coordinator: MainCoordinator, artist: Artist) {
        self.view = view
        self.coordinator = coordinator
        self.artist = artist
    }
    
    func loadAlbums() {
        switch ReachabilityCheck.shared.canAccess() {
        case .on:
            getTopAlbums()
        case .off:
            loadLocalAlbums()
        }
    }
    
    private func getTopAlbums() {
        TopArtistsRequestService.getTopAlbums(artistName: artist.name) { [weak self] (topAlbums, error) in
            if let albums = topAlbums?.topalbums {
                self?.albums = Array(albums.album)
                self?.view?.reloadInfo()
                self?.updateRealmAlbums(albums: albums)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadLocalAlbums() {
        if let realmAlbums = RealmManager.getAlbumsFromRealm(artist: artist.name) {
            albums = Array(realmAlbums.album)
            view?.reloadInfo()
        }
    }
    
    private func updateRealmAlbums(albums: Albums) {
        DispatchQueue.main.async {
            RealmManager.saveAlbumsToRealm(albums: albums)
        }
    }
}
