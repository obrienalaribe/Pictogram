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
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .blue
        sb.isHidden = true
        sb.showsCancelButton = true
        return sb
    }()
    
    let titleView : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "SLOCO"

        label.isUserInteractionEnabled = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "sloco_logo"))
        iv.frame = CGRect(x: 0, y: -5, width: 40, height: 35)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = BrandColours.secondary
        self.collectionView!.register(HomePostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.setupNavigationItems()
        fetchPosts()
    }
    
    func setupNavigationItems() {
        navigationItem.title = "SLOCO"
//        navigationController?.navigationBar.topItem?.titleView = logoImageView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.scrollToTop))
        
        logoImageView.addGestureRecognizer(tap)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search_unselected"), style: .plain, target: self, action: #selector(activateSearch))
        navigationController?.navigationBar.tintColor = BrandColours.primary
        
        let navBar =  navigationController?.navigationBar
        navBar?.addSubview(searchBar)
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        searchBar.delegate = self

        
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
        
        var height : CGFloat = 50 + 8 + 8 //userinfo + profile image height
        height += view.frame.width + 50 //50 = space for bottom buttons
        return CGSize(width: view.frame.width, height: height)
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
                return
            }
            
            print("Successfully fetched using generic DAO")
            
            let post = Post(user: User(dictionary: [:]), dictionary: dictionary)
            self.posts.append(post)
            self.collectionView?.reloadData()
            
        }

        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        DaoManager.shared.fetchSingleEntity(model: "users", id: uid, completionHandler: {(err, dictionary) in
            if err != nil {
                print("HomeController failed to fetch users")
                return
            }
            
            print("Successfully fetched user using generic DAO")
            let user = User(dictionary: dictionary)
         
        })
        
       
    }
    
    //Move all these to presenters
    func showNotifications(){
        let notificationController = NotificationController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    func activateSearch() {
        self.searchBar.isHidden = false
        self.searchBar.becomeFirstResponder()
    }
    
    func deactivateSearch(){
        self.searchBar.isHidden = true
        self.searchBar.resignFirstResponder()
    }
    
    
    


}
