//
//  MockProfileHeader.swift
//  Pictogram
//
//  Created by mac on 4/9/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit


class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let profileImageUrl = user?.profileImageUrl else {return}
            profileImageView.loadImage(urlString: profileImageUrl)
        }
    }
    let backgroundImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = BrandColours.primary
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = iv.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        iv.addSubview(blurEffectView)
        return iv
    }()
    
    let profileImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 3
        iv.layer.borderColor = BrandColours.tertiaryDark.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    let metricLabel : UILabel = {
        let label = UILabel()
        label.text = "1,000"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.addImage(imageName: "gold-star")
        label.backgroundColor = .black
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "OBrien Alaribe", attributes: [NSForegroundColorAttributeName: BrandColours.primaryDark, NSFontAttributeName: UIFont.systemFont(ofSize: 14)] )
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    let courseLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Economics & Management Studies", attributes: [NSForegroundColorAttributeName: BrandColours.primaryDark, NSFontAttributeName: UIFont.systemFont(ofSize: 14)] )
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let editProfileBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.borderColor = BrandColours.primary.cgColor
        btn.setTitleColor(BrandColours.primary, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        backgroundImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
   
        addSubview(metricLabel)
        metricLabel.anchor(top: nil, left: nil, bottom: profileImageView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 20)
        metricLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        let infoView = UIStackView(arrangedSubviews: [usernameLabel, courseLabel])

        addSubview(infoView)
        infoView.distribution = .fillEqually
        infoView.axis = .vertical
        
        infoView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        addSubview(editProfileBtn)
        editProfileBtn.anchor(top: infoView.bottomAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 100, height: 30)
        editProfileBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true


    }
 
    
       
}

extension UILabel
{
    func addImage(imageName: String)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
            let strLabelText: NSAttributedString = NSAttributedString(string: " \(self.text!)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),NSForegroundColorAttributeName: BrandColours.tertiaryDark])
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        
    }
    
   
}
