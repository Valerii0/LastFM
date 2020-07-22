//
//  AttributeArtist.swift
//  LastFM
//
//  Created by Valerii Petrychenko on 7/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class AttributeArtist: Object, Codable {
    dynamic var country: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case country = "country"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        country = try container.decode(String.self, forKey: .country)
    }
    
    required init()
    {
        super.init()
    }
}
