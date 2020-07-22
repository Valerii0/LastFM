//
//  AppConstants.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

enum Api: String {
    case url = "http://ws.audioscrobbler.com/2.0"
    case api_key = "e81f61890b7ff8633ca024d0faa449e7"
    case getTopArtists = "geo.gettopartists"
    case getTopAlbums = "artist.gettopalbums"
    case format = "json"
}

enum InternetState {
    case on
    case off
}

enum Country: String {
    case usa = "United states"
    case ukraine = "Ukraine"
    case germany = "Germany"
    
    static let allValues = [usa, ukraine, germany]
}

enum ImageSizesConstants: String {
    case small = "small"
    case medium = "medium"
    case large = "large"
    case extralarge = "extralarge"
    case mega = "mega"
}

enum TopArtistsConstants: String {
    case topArtistTableViewCell = "TopArtistTableViewCell"
    case title = "Top Artists by country: "
    static let topArtistTableViewCellHeight: CGFloat = 80
}

enum ChangeCountryConstants: String {
    case countriesTableViewCell = "countriesTableViewCell"
    case backTitle = "Back"
    static let cornerRadius: CGFloat = 5
}

enum ArtistConstants: String {
    case albumCollectionViewCell = "AlbumCollectionViewCell"
    static let countCellPerRow = 2
    static let indentWith: CGFloat = 10
    static let cornerRadius: CGFloat = 5
}
