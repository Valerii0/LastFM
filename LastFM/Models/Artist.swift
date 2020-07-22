//
//  Artist.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Artist: Object, Codable {
    dynamic var name: String = ""
    dynamic var listeners: String = ""
    dynamic var mbid: String = ""
    dynamic var url: String = ""
    dynamic var streamable: String = ""
    dynamic var image = RealmSwift.List<Photo>()
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", listeners = "listeners", mbid = "mbid", url = "url", streamable = "streamable", image = "image"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        listeners = try container.decode(String.self, forKey: .listeners)
        mbid = try container.decode(String.self, forKey: .mbid)
        url = try container.decode(String.self, forKey: .url)
        streamable = try container.decode(String.self, forKey: .streamable)
        if let images = try? container.decode([Photo].self, forKey: .image) {
            self.image.append(objectsIn: images)
        }
    }
    
    required init()
    {
        super.init()
    }
}
