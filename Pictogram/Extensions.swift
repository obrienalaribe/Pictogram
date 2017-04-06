//
//  Extensions.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 06/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
