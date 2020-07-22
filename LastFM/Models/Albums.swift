//
//  Albums.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/21/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Albums: Object, Codable {
    dynamic var album = RealmSwift.List<Album>()
    dynamic var attribute: AttributeAlbum?
    
    private enum CodingKeys: String, CodingKey {
        case album = "album", attribute = "@attr"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let albums = try? container.decode([Album].self, forKey: .album) {
            self.album.append(objectsIn: albums)
        }
        attribute = try container.decode(AttributeAlbum.self, forKey: .attribute)
    }
    
    required init()
    {
        super.init()
    }
}
