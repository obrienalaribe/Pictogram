//
//  Post.swift
//  Pictogram
//
//  Created by mac on 4/9/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import Foundation

struct Post {
    
    let imageUrl: String
    
    init(dictionary: [String:Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }

}
