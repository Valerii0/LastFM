//
//  Photo.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Photo: Object, Codable {
    dynamic var text: String = ""
    dynamic var size: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case text = "#text", size = "size"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        size = try container.decode(String.self, forKey: .size)
    }
    
    required init()
    {
        super.init()
    }
}
