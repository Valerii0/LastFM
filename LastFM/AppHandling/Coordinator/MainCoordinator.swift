//
//  MainCoordinator.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

protocol Coordinatable {
    var mainRouter: Routable { get set }
}

final class MainCoordinator: Coordinatable {
    var window: UIWindow
    var mainRouter: Routable

    private enum StoryboardsName: String {
        case topArtistsStoryboard = "TopArtistsStoryboard"
        case changeCountryStoryboard = "ChangeCountryStoryboard"
        case artistStoryboard = "ArtistStoryboard"
    }
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.mainRouter = RouterType.mainRouter.router
        self.mainRouter.navigationController.modalPresentationStyle = .overFullScreen
    }
    
    func configure() {
        window.rootViewController = topArtistsViewController()
    }
    
    func topArtistsViewController() -> UINavigationController {
        let viewController = TopArtistsViewController.instantiate(storyboardName: StoryboardsName.topArtistsStoryboard.rawValue)
        let configurator = TopArtistsConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        mainRouter.navigationController.viewControllers = [viewController]
        return mainRouter.navigationController
    }
    
    func presentChangeCountryViewController(delegate: ChangeCountryPresenterDelegate?) {
        let viewController = ChangeCountryViewController.instantiate(storyboardName: StoryboardsName.changeCountryStoryboard.rawValue)
        let configurator = ChangeCountryConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, delegate: delegate)
        mainRouter.present(controller: viewController, animated: true)
    }
    
    func pushArtistViewController(artist: Artist) {
        let viewController = ArtistViewController.instantiate(storyboardName: StoryboardsName.artistStoryboard.rawValue)
        let configurator = ArtistConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, artist: artist)
        mainRouter.push(controller: viewController, animated: true)
    }
    
    func mainRouterPop() {
        mainRouter.pop(animated: true)
    }
    
    func mainRouterDismiss() {
        mainRouter.dismiss(animated: true)
    }
}
