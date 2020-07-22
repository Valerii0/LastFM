//
//  Configurator.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

protocol TopArtistsConfigurable {
    func configure(viewController: TopArtistsViewController, coordinator: MainCoordinator)
}

class TopArtistsConfigurator: TopArtistsConfigurable {
    func configure(viewController: TopArtistsViewController, coordinator: MainCoordinator) {
        let topArtistsPresenter = TopArtistsPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = topArtistsPresenter
    }
}

protocol ArtistConfigurable {
    func configure(viewController: ArtistViewController, coordinator: MainCoordinator, artist: Artist)
}

class ArtistConfigurator: ArtistConfigurable {
    func configure(viewController: ArtistViewController, coordinator: MainCoordinator, artist: Artist) {
        let artistPresenter = ArtistPresenter(view: viewController, coordinator: coordinator, artist: artist)
        viewController.presenter = artistPresenter
    }
}

protocol ChangeCountryConfigurable {
    func configure(viewController: ChangeCountryViewController, coordinator: MainCoordinator, delegate: ChangeCountryPresenterDelegate?)
}

class ChangeCountryConfigurator: ChangeCountryConfigurable {
    func configure(viewController: ChangeCountryViewController, coordinator: MainCoordinator, delegate: ChangeCountryPresenterDelegate?) {
        let changeCountryPresenter = ChangeCountryPresenter(view: viewController, coordinator: coordinator, delegate: delegate)
        viewController.presenter = changeCountryPresenter
    }
}
