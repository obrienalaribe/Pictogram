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
    
    var masterViewController : UserProfileController? = nil {
        didSet{
            editProfileBtn.addTarget(masterViewController, action: #selector(masterViewController?.editProfile), for: .touchUpInside)
            
            let tap = UITapGestureRecognizer(target: masterViewController, action: #selector(masterViewController?.handlePhotoUpload))
            profileImageView.addGestureRecognizer(tap)
            
        }
    }
    
    let backgroundImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = BrandColours.primary
        return iv
    }()
    
    let profileImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "image-placeholder")
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 3
        iv.layer.borderColor = BrandColours.tertiaryDark.cgColor
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let metricView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0.6
        return view
    }()
    
    let metricLabel : UILabel = {
        let label = UILabel()
        label.text = "10000"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.addImage(imageName: "gold-star")
        label.textAlignment = .center
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Ebukz", attributes: [NSForegroundColorAttributeName: BrandColours.primaryDark, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)] )
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    let courseLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSForegroundColorAttributeName: BrandColours.primaryDark, NSFontAttributeName: UIFont.systemFont(ofSize: 14)] )
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let uniLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSForegroundColorAttributeName: BrandColours.primaryDark, NSFontAttributeName: UIFont.systemFont(ofSize: 14)] )
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let editProfileBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
        btn.layer.borderColor = BrandColours.primary.cgColor
        btn.setTitleColor(BrandColours.primary, for: .normal)
        btn.setImage(#imageLiteral(resourceName: "edit").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = BrandColours.primary
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 2, 2)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
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
   
        addSubview(editProfileBtn)
        editProfileBtn.anchor(top: backgroundImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 80, height: 35)
        
        addSubview(metricView)
        
        metricView.anchor(top: nil, left: nil, bottom: profileImageView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 80, height: 40)
        
        metricView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(metricLabel)
        metricLabel.anchor(top: metricView.topAnchor, left: metricView.leftAnchor, bottom: metricView.bottomAnchor, right: metricView.rightAnchor, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2, width: 0, height: 0)
        let infoView = UIStackView(arrangedSubviews: [usernameLabel, courseLabel, uniLabel])
        
        addSubview(infoView)
        infoView.distribution = .fillEqually
        infoView.axis = .vertical
        infoView.spacing = 1.5
        
        infoView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 0)

    }
    
   
 
    
       
}

extension UILabel
{
    func addImage(imageName: String)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
            let strLabelText: NSAttributedString = NSAttributedString(string: " \(self.text!)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),NSForegroundColorAttributeName: BrandColours.tertiaryDark])
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        
    }
    
   
}

