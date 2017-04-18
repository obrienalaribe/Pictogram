//
//  MockUserProfileController.swift
//  Pictogram
//
//  Created by mac on 4/9/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

private let cellId = "Cell"
private let headerId = "Header"


class UserProfileController: UICollectionViewController {
    private var posts = [Post]()
    private var user : User? {
        didSet {
            guard let user = user else {return}
            setupUserDetails(user: user)
        }
    }
    
    var header: UserProfileHeader!
    
    var refreshCtrl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Ebukz"
        setupLogoutBtn()
        
        // Register cell classes
        self.collectionView!.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        self.collectionView?.delegate = self

//        fetchPosts()
        fetchUser()
        fetchOrderedPosts()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    //space for horizontal grid
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //space for vertical grid
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        self.header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeader
        self.header.user = self.user
        self.header.masterViewController = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePhotoCell
        cell.post = posts[indexPath.item]
    
        // Configure the cell
    
        return cell
    }

    
    // MARK: UICollectionViewDelegate
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func fetchUser() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            guard let userDictionary = snapshot.value as? [String:Any] else {return}
            self.user = User(dictionary: userDictionary)
        }) { (err) in
            print("Failed to fetch user", err)
        }
    }
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        
        let ref = FIRDatabase.database().reference().child("posts").child(uid)
        
        //can paginate here
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            guard let user = self.user else {return}
            let post = Post(user: user, dictionary: dictionary)
            self.posts.append(post)
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch ordered memes for profile", err)
        }
    }

    fileprivate func setupUserDetails(user: User) {
        navigationItem.title = user.username
    }
    
    fileprivate func setupLogoutBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(handleSettingsAction) )
        navigationController?.navigationBar.tintColor = BrandColours.primary
    }
    
    func editProfile(){
        let viewController = UserProfileEditController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func handleSettingsAction() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try FIRAuth.auth()?.signOut()
                
                print("CACHE CONTAINS \(AppCache.shared.images)")
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signoutErr {
                print("Failed to sign out:", signoutErr)
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func handlePhotoUpload() {
        let imageHandler = ImageHandler()
        imageHandler.showImageSourceOptions(viewController: self)
        
    }
    
}

extension UserProfileController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height * 0.48)
    }
}

// MARK: Image Picker

extension UserProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            print("got edited image")
            self.header.profileImageView.image = editedImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print("got original image")
            self.header.profileImageView.image = originalImage
        }
        
        //TODO: Forward to DaoManager to forward to DB
        dismiss(animated: true, completion: nil)
    }

}



