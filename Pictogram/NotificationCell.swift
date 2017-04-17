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
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    let postImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let caption: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Stephanie ", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedString.append(NSAttributedString(string: "liked your picture ", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        attributedString.append(NSAttributedString(string: "2hrs ago", attributes: [NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedString
        
        label.numberOfLines = 2
        return label
    }()
    
    let divider : UIView = {
        let view = UIView()
        view.backgroundColor = BrandColours.tertiaryDark
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = BrandColours.tertiary
        
        addSubview(userImageView)
       userImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 42, height: 38)
        userImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(postImageView)
        postImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 45, height: 45)
        postImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(caption)
        caption.anchor(top: nil, left: userImageView.rightAnchor, bottom: nil, right: postImageView.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        caption.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(divider)
        divider.anchor(top: userImageView.bottomAnchor, left: caption.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: -5, paddingBottom: 5, paddingRight: 0, width: 0, height: 1)
        
       

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
