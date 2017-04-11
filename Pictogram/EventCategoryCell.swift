//
//  EventCategoryCell.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 11/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class EventCategoryCell: UICollectionViewCell {
    
    let categoryNameLabel : UILabel = {
        let label = UILabel()
        label.text = "HIP HOP"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    let divider : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let eventsCollectioView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(EventCell.self, forCellWithReuseIdentifier: cellId)
        
        cv.backgroundColor = .white
        
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        
    }
    
    
    func setupCollectionView() {
        addSubview(categoryNameLabel)
        addSubview(eventsCollectioView)
        addSubview(divider)
        
//        eventsCollectioView.backgroundColor = .red
        
        eventsCollectioView.showsHorizontalScrollIndicator = false
        
        categoryNameLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        divider.anchor(top: categoryNameLabel.bottomAnchor, left: nil, bottom: eventsCollectioView.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width/2, height: 0.8)
        divider.centerXAnchor.constraint(equalTo: categoryNameLabel.centerXAnchor).isActive = true

        
        eventsCollectioView.anchor(top: divider.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        eventsCollectioView.dataSource = self
        eventsCollectioView.delegate = self
        

    }
   
    
}

extension EventCategoryCell : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}


extension EventCategoryCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: frame.height - 48) //pad inner cells
    }
    
    
}
