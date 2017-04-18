//
//  EventCell.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            presentData(event: event)
        }
    }
    var imageUrl: String? {
        didSet {
            guard let url = imageUrl else {return}
            eventImageView.loadImage(urlString: url)
        }
    }
    
    let eventImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "image-placeholder")
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = BrandColours.labelLight
        label.textAlignment = .center
        return label
    }()
    
    let venueLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = UIColor.gray
        label.tintColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    let dividerView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(eventImageView)
        eventImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (frame.height * 0.60))
       
        addSubview(nameLabel)
        nameLabel.anchor(top: eventImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        addSubview(venueLabel)
        venueLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
//        
//        addSubview(dividerView)
//        dividerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 2, paddingRight: 12, width: 0, height: 0.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func presentData(event: Event) {
        self.nameLabel.text = event.name
        self.eventImageView.loadImage(urlString: event.largeImageUrl)
        self.venueLabel.text = event.venue.name
      
        self.venueLabel.addImage(imageName: "location_marker", fontSize: self.venueLabel.font.pointSize)

    }

}
