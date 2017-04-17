//
//  Venue.swift
//  Pictogram
//
//  Created by mac on 4/17/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import Foundation

struct Venue {
    var id : Int64
    var name: String
    var address: String
    var town: String
    var postcode: String
    var country: String
    var phone: String
    var lat: Double
    var lng: Double
    var type: String
    
    init(dictionary : [String:Any]) {
        self.id = dictionary[VenueAttributes.id.rawValue] as? Int64 ?? -1
        self.name = dictionary[VenueAttributes.name.rawValue] as? String ?? ""
        self.address = dictionary[VenueAttributes.address.rawValue] as? String ?? ""
        self.town = dictionary[VenueAttributes.town.rawValue] as? String ?? ""
        self.postcode = dictionary[VenueAttributes.postcode.rawValue] as? String ?? ""
        self.country = dictionary[VenueAttributes.country.rawValue] as? String ?? ""
        self.phone = dictionary[VenueAttributes.phone.rawValue] as? String ?? ""
        self.lat = dictionary[VenueAttributes.lat.rawValue] as? Double ?? 0.0
        self.lng = dictionary[VenueAttributes.lng.rawValue] as? Double ?? 0.0
        self.type = dictionary[VenueAttributes.type.rawValue] as? String ?? ""
    }
}

enum VenueAttributes : String {
    case id = "id"
    case name = "name"
    case address = "address"
    case town = "town"
    case postcode = "postcode"
    case country = "country"
    case phone = "phone"
    case lat = "latitude"
    case lng = "longitude"
    case type = "type"
    case rating = "rating"
}
