//
//  Event.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 11/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import Foundation



struct Event {
    var id : String
    var code: String
    var name : String
    var venue: Venue
    var imageUrl: String
    var largeImageUrl: String
    var link: String
    var date: String
    var start: String
    var end: String
    var description: String
    var entryPrice: String
//    var genres: [EventGenre]
//    var artists: [Artist]
    
    
    init(dictionary: [String:Any]) {
        self.id = dictionary[EventAttributes.id.rawValue] as? String ?? ""
        self.code = dictionary[EventAttributes.eventCode.rawValue] as? String ?? ""
        self.name = dictionary[EventAttributes.name.rawValue] as? String ?? ""
        self.venue = Venue(dictionary: dictionary[EventAttributes.venue.rawValue as? String ?? ""] as? [String : Any] ?? [:]) //need test object
        self.imageUrl = dictionary[EventAttributes.imageUrl.rawValue] as? String ?? ""
        self.largeImageUrl = dictionary[EventAttributes.largeImageUrl.rawValue] as? String ?? ""
        self.link = dictionary[EventAttributes.link.rawValue] as? String ?? ""
        self.date = dictionary[EventAttributes.date.rawValue] as? String ?? ""
        self.start = dictionary[EventAttributes.start.rawValue] as? String ?? "" //use opening times to avoid logic
        self.end = dictionary[EventAttributes.end.rawValue] as? String ?? ""
        self.description = dictionary[EventAttributes.description.rawValue] as? String ?? ""
        self.entryPrice = dictionary[EventAttributes.entryPrice.rawValue] as? String ?? ""
//        self.genres = EventGenre(dictionary: dictionary[EventAttributes.genres.rawValue as? String ?? ""] as? [String:Any] ?? [:])
    }
    
}


struct EventGenre {
    var id : Int64
    var name: String
    
    init(dictionary: [String:Any]) {
        self.id = dictionary[EventAttributes.id.rawValue] as? Int64 ?? -1
        self.name = dictionary[EventAttributes.name.rawValue] as?  String ?? ""
    }
}


enum EventAttributes : String {
    case id = "id"
    case name = "eventname"
    case venue = "venue"
    case description = "description"
    case eventCode = "EventCode"
    case imageUrl = "imageurl"
    case largeImageUrl = "largeimageurl"
    case link = "link"
    case date = "date"
    case start = "startdate"
    case end = "enddate"
    case entryPrice = "entryprice"
    case genres = "genres"
    case artists = "artists"
}
