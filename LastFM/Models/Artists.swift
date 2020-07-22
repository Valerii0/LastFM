//
//  Artists.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Artists: Object, Codable {
    dynamic var artist = RealmSwift.List<Artist>()
    dynamic var attribute: AttributeArtist?
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artist", attribute = "@attr"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let artists = try? container.decode([Artist].self, forKey: .artist) {
            self.artist.append(objectsIn: artists)
        }
        attribute = try container.decode(AttributeArtist.self, forKey: .attribute)
    }
    
    required init()
    {
        super.init()
    }
}
