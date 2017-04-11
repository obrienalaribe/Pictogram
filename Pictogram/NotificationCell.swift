//
//  NoticationCell.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class NotificationCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let profileImageUrl = user?.profileImageUrl else {return}
            userImageView.loadImage(urlString: profileImageUrl)
        }
    }
    
    let userImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 2
        iv.layer.borderColor = BrandColours.tertiaryDark.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    let postImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.layer.borderWidth = 2
        iv.layer.borderColor = BrandColours.tertiaryDark.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = BrandColours.primaryDark
        
        addSubview(userImageView)
        userImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
