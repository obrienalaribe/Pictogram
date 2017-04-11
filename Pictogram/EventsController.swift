//
//  EventsController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(EventCategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.backgroundColor = BrandColours.secondary

        navigationItem.title = "Student Events"
 
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        if indexPath.item % 2 == 0 {
//            return CGSize(width: view.frame.width, height: 80)
//        }
        let height : CGFloat = 230
        return CGSize(width: view.frame.width, height: height)
    }
    
    //space for horizontal grid
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //space for vertical grid
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventCategoryCell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


var urls = ["https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/f8d3cd88042e9cb8edb138c68d40600d.1480452248.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/5693f0afa74a3e3d7d71e19013cb9757.1491224467.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/5b9fd32ed7de39adc5aca65368939530.1484568277.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/c6159168dca606e14b374fc02d6641ce.1460715843.png", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/014c84cb8bf1028e948e16d70e95ba60.1491304747.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/949ed9f8a51de8935246f6a77a9f113b.1490971369.png", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/6c62e80dedf6c322770dc6edea567488.1490009717.jpg","https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/edeb414b7311a5cd4d9261fcbddd779d.1482149586.png","https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/f8d3cd88042e9cb8edb138c68d40600d.1480452248.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/5693f0afa74a3e3d7d71e19013cb9757.1491224467.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/5b9fd32ed7de39adc5aca65368939530.1484568277.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/c6159168dca606e14b374fc02d6641ce.1460715843.png", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/014c84cb8bf1028e948e16d70e95ba60.1491304747.jpg", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/949ed9f8a51de8935246f6a77a9f113b.1490971369.png", "https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/6c62e80dedf6c322770dc6edea567488.1490009717.jpg","https://app.resrc.it/O=80/C=AR4x3/S=W200,U/https://www.ticketarena.co.uk/cms_media/images/events/edeb414b7311a5cd4d9261fcbddd779d.1482149586.png" ]
