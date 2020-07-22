//
//  TopArtistsPresenter.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol TopArtistsView: class {
    func reloadInfo(country: Country)
}

class TopArtistsPresenter {
    private weak var view: TopArtistsView?
    private var coordinator: MainCoordinator?
    private var country: Country?
    private var artists = [Artist]()
    var artistsToShow: [Artist] {
        return artists
    }
    
    init(view: TopArtistsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func presentChangeCountryViewController() {
        coordinator?.presentChangeCountryViewController(delegate: self)
    }
    
    func pushArtistViewController(index: Int) {
        coordinator?.pushArtistViewController(artist: artists[index])
    }
    
    private func dismiss() {
        coordinator?.mainRouterDismiss()
    }
    
    private func loadArtists() {
        if let country = country {
            switch ReachabilityCheck.shared.canAccess() {
            case .on:
                getTopArtists(country: country)
            case .off:
                loadLocalTopArtists(country: country)
            }
        }
    }
    
    private func getTopArtists(country: Country) {
        TopArtistsRequestService.getTopArtists(country: country.rawValue) { [weak self] (topArtists, error) in
            if let artists = topArtists?.topartists {
                artists.artist.sort(by: {$0.name.localizedStandardCompare($1.name) == .orderedAscending})
                self?.artists = Array(artists.artist)
                self?.view?.reloadInfo(country: country)
                self?.updateRealmArtists(artists: artists)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadLocalTopArtists(country: Country) {
        if let realmArtists = RealmManager.getArtistsFromRealm(country: country.rawValue) {
            artists = Array(realmArtists.artist)
            view?.reloadInfo(country: country)
        }
    }
    
    private func updateRealmArtists(artists: Artists) {
        DispatchQueue.main.async {
            RealmManager.saveArtistsToRealm(artists: artists)
        }
    }
}

extension TopArtistsPresenter: ChangeCountryPresenterDelegate {
    func changeCountry(country: Country) {
        dismiss()
        self.country = country
        loadArtists()
    }
}
