//
//  MockProfileHeader.swift
//  Pictogram
//
//  Created by mac on 4/9/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit


class MockProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            print("did set \(user?.username)")
            setupProfileImage()
            usernameLabel.text = "Leeds university"
        }
    }
    let backgroundImageView : UIImageView = {
        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = BrandColours.tertiary
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = iv.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        iv.addSubview(blurEffectView)
        return iv
    }()
    
    let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile_image")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 3
        iv.layer.borderColor = BrandColours.tertiaryDark.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    let starMetric : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gold-star")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let metricLabel : UILabel = {
        let label = UILabel()
        label.text = "1,000"
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
        backgroundImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30).isActive = true
        
        let metricView = UIStackView(arrangedSubviews: [starMetric, metricLabel])
        addSubview(metricView)
        metricView.distribution = .fillEqually
        metricView.spacing = 2
        
        //user nsattachmetn instead
        metricView.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 12)
        metricView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        let infoView = UIStackView(arrangedSubviews: [usernameLabel, courseLabel])

        addSubview(infoView)
        infoView.distribution = .fillEqually
        infoView.axis = .vertical
        
        infoView.anchor(top: metricView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        addSubview(editProfileBtn)
        editProfileBtn.anchor(top: infoView.bottomAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 100, height: 50)
        editProfileBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true


    }
 
    
   
    
    fileprivate func setupProfileImage() {
        
        guard let profileImageUrl = user?.profileImageUrl else {return}
        guard let url = URL(string: profileImageUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch profile image", err)
            }
            
            guard let data = data else {return}
            
            let image = UIImage(data: data)
            
            //need to get back on the main queue
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            }.resume()
        
        
        
    }
    
    
    
    
}
