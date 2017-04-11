//
//  CustomImageView.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {

    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String){
        
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        print("fetching image over network")
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image", err)
                return
            }
            //since image loading done asynchronously in background thread and return at varying times due to image size
            // last url that called the task should match the returned image url
            //This prevents image duplicates
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()

    }
    
}

