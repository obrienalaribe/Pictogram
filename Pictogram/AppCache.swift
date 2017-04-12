//
//  Cache.swift
//  Pictogram
//
//  Created by mac on 4/12/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class AppCache {
    
    static let shared = AppCache()
    let images = NSCache<NSString, UIImage>()

    init() {
        print("APP CACHE INIT")
    }

    
}
