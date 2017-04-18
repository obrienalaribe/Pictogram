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
             guard let username = post?.user.username else { return }
            userInfo.attributedText = setupUserLabel(username: username, university: "University of Leeds")
        }
    }
    
    let userInfo : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "obrienalaribe\n", attributes: [NSForegroundColorAttributeName:  UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)] )
        
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
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let optionsBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("•••", for: .normal)
        btn.setTitleColor(BrandColours.primary, for: .normal)
        return btn
    }()
    
    let starBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "gold-star"), for: .normal)
        return btn
    }()
    
    let commentBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "chat"), for: .normal)
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.darkGray
        
        setupUserHeader()
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        addSubview(optionsBtn)
        optionsBtn.anchor(top: topAnchor, left: nil, bottom: postImageView.topAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews: [starBtn, commentBtn])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.anchor(top: postImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
    }
   
    
    func setupUserHeader() {
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        addSubview(userInfo)
        
        userInfo.backgroundColor = .red
        userInfo.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    }
    
    private func setupUserLabel(username: String, university: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(username)\n", attributes: [NSForegroundColorAttributeName:  UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)] )
        
        attributedText.append(NSAttributedString(string: university, attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 10)]))
        
        return attributedText

    }
}
