//
//  CustomImageView.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit


class CustomImageView: UIImageView {

    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String){
        
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = AppCache.shared.images.object(forKey: urlString as NSString) {
            // use the cached version
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            print("fetching image over network")
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
            guard let photoImage = UIImage(data: imageData) else {return}
            
            AppCache.shared.images.setObject(photoImage, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()

    }
    
}

