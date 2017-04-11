//
//  Event.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 11/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import Foundation


struct EventCategory {
    var name: String
    var events: [Event]
}

struct Event {
    var name : String
    var imageUrl: String
    var status: String
    
    init(dictionary: [String:Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.status = dictionary["status"] as? String ?? ""
    }
    
}
