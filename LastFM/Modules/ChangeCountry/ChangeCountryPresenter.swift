//
//  ChangeCountryPresenter.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol ChangeCountryPresenterDelegate: class {
    func changeCountry(country: Country)
}

protocol ChangeCountryView: class {
}

class ChangeCountryPresenter {
    private weak var view: ChangeCountryView?
    private var coordinator: MainCoordinator?
    private weak var delegate: ChangeCountryPresenterDelegate?
    var countriesToShow: [Country] {
        return Country.allValues
    }
    
    init(view: ChangeCountryView, coordinator: MainCoordinator, delegate: ChangeCountryPresenterDelegate?) {
        self.view = view
        self.coordinator = coordinator
        self.delegate = delegate
    }
    
    func dismiss() {
        coordinator?.mainRouterDismiss()
    }
    
    func changeCountry(index: Int) {
        delegate?.changeCountry(country: Country.allValues[index])
    }
}
