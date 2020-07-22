//
//  AttributeAlbum.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class AttributeAlbum: Object, Codable {
    dynamic var artist: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artist"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
    }
    
    required init()
    {
        super.init()
    }
}
