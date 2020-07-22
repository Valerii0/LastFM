//
//  Album.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/21/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Album: Object, Codable {
    dynamic var name: String = ""
    dynamic var playcount: Int = 0
    dynamic var mbid: String? = nil
    dynamic var url: String? = nil
    dynamic var image = RealmSwift.List<Photo>()
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", playcount = "playcount", mbid = "mbid", url = "url", image = "image"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        playcount = try container.decode(Int.self, forKey: .playcount)
        mbid = try? container.decode(String.self, forKey: .mbid)
        url = try container.decode(String.self, forKey: .url)
        if let images = try? container.decode([Photo].self, forKey: .image) {
            self.image.append(objectsIn: images)
        }
    }
    
    required init()
    {
        super.init()
    }
}
