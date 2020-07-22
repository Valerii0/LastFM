//
//  RealmManager.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/21/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class RealmManager {
    static func getArtistsFromRealm(country: String) -> Artists? {
        do {
            let realm = try Realm()
            let artists = realm.objects(Artists.self).filter("attribute.country = '\(country)'").first
            return artists
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func saveArtistsToRealm(artists: Artists) {
        do {
            let realm = try Realm()
            if let realmArtists = realm.objects(Artists.self).filter("attribute.country = '\(artists.attribute?.country ?? "")'").first {
                do {
                    try realm.write {
                        realm.delete(realmArtists)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            do {
                try realm.write {
                    realm.add(artists)
                }
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getAlbumsFromRealm(artist: String) -> Albums? {
        do {
            let realm = try Realm()
            let albums = realm.objects(Albums.self).filter("attribute.artist = '\(artist)'").first
            return albums
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func saveAlbumsToRealm(albums: Albums) {
        do {
            let realm = try Realm()
            if let realmAlbums = realm.objects(Albums.self).filter("attribute.artist = '\(albums.attribute?.artist ?? "")'").first {
                do {
                    try realm.write {
                        realm.delete(realmAlbums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            do {
                try realm.write {
                    realm.add(albums)
                }
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
