//
//  HomeControllerController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

private let reuseIdentifier = "Cell"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = BrandColours.secondary
        self.collectionView!.register(HomePostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.setupNavigationItems()
        fetchPosts()
    }
    
    override func didReceiveMemoryWarning() {
        //flush image cache when it is too large (You could also check creation date of post and remove oldest ones)
        imageCache.removeAll()
    }
    
    func setupNavigationItems() {
        navigationItem.title = "SLOCO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera"), style: .plain, target: self, action: #selector(showCamera))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(showNotifications))
        navigationController?.navigationBar.tintColor = BrandColours.primary
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomePostCell
        // Configure the cell
        cell.post = posts[indexPath.item]
    
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: (view.frame.height - 50))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0)
    }

    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    
    fileprivate func fetchPosts() {
        DaoManager.shared.fetchCollections(model: "posts") { (err, dictionary) in
            
            if let err = err {
                print("HomeController failed to fetch posts")
            }
            
            print("Successfully fetched using generic DAO")
                        
            let post = Post(dictionary: dictionary)
            print(post.imageUrl)
            self.posts.append(post)
            self.collectionView?.reloadData()
            
        }
    }
    
    func showNotifications(){
        let notificationController = NotificationController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    func showCamera() {
        print("camera ...")
    }
    
    


}
