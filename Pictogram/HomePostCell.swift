//
//  HomePostCell.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let postImageUrl = post?.imageUrl else {return}
            postImageView.loadImage(urlString: postImageUrl)
            
        }
    }
    
    let userHeader: UIView = {
        let iv = UIView()
        iv.backgroundColor = BrandColours.secondary
        return iv
    }()
    
    
    let userInfo : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "obrienalaribe \n", attributes: [NSForegroundColorAttributeName:  UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)] )
        
        attributedText.append(NSAttributedString(string: "University of Leeds", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 10)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let profileImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    let postImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = BrandColours.secondary
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BrandColours.secondary
        
        setupUserHeader()
        
        addSubview(postImageView)
        postImageView.anchor(top: userHeader.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.height * 0.7)
    }
   
    
    func setupUserHeader() {
        addSubview(userHeader)
        userHeader.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 50)
        userHeader.addSubview(profileImageView)
        
        profileImageView.anchor(top: userHeader.topAnchor, left: userHeader.leftAnchor, bottom: userHeader.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
        
        addSubview(userInfo)
        
        userInfo.anchor(top: userHeader.topAnchor, left: profileImageView.rightAnchor, bottom: userHeader.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: userHeader.frame.width, height: 0)

    }
}
