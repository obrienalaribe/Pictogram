//
//  EventsPageHeader.swift
//  Pictogram
//
//  Created by mac on 4/17/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class EventsPageHeader: UICollectionViewCell {
    
    
    let backgroundImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "image-placeholder")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = BrandColours.primary
        return iv
    }()
    
    
    let eventNameLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Event Title", attributes: [NSForegroundColorAttributeName: BrandColours.primaryDark, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)] )
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()

    
    let purchaseTicketBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Get Tickets", for: .normal)
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
        backgroundColor = .red
        addSubview(backgroundImageView)
        backgroundImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
   
        
    }
    
    
    
    
    
}
