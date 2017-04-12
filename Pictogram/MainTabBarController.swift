//
//  MainTabBarController.swift
//  Pictogram
//
//  Created by mac on 4/6/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bootstrapLookAndFeel()
        
        self.delegate = self
        
        if FIRAuth.auth()?.currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                self.present(navigationController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
        
        //home
//        let homeNavController = templateNavContoller(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        let homeNavController = templateNavContoller(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController:  HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //events
        let eventNavController = templateNavContoller(unselectedImage: #imageLiteral(resourceName: "event_unselected"), selectedImage: #imageLiteral(resourceName: "event_selected"), rootViewController:  EventsController(collectionViewLayout: UICollectionViewFlowLayout()))

        // camera
        let cameraController = templateNavContoller(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        //notification
        let notificationNavController = templateNavContoller(unselectedImage: #imageLiteral(resourceName: "bell_unselected"), selectedImage: #imageLiteral(resourceName: "bell_selected"), rootViewController: NotificationController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //user profile
        let userProfileNavController = templateNavContoller(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController:  UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))

        
        viewControllers = [homeNavController, eventNavController, cameraController, notificationNavController, userProfileNavController]
        
        
        guard let items = tabBar.items else {return}
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavContoller(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
  
}

extension MainTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            let photoSelectorController = PhotoSelectorControllerController(collectionViewLayout: UICollectionViewFlowLayout())
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
}

// Setup Custom Theme Across App
extension MainTabBarController {
    
    func bootstrapLookAndFeel(){
        var navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.barTintColor = BrandColours.secondary
        
        let font = UIFont(name: "Avenir Next", size: 20)!
        
        let attributes: [String: AnyObject] = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: BrandColours.primary
        ]
        
        navigationBarAppearance.titleTextAttributes = attributes
        
        
        //Setup Tab Bar
        
        var tabBarAppereance = UITabBar.appearance()
        
        tabBarAppereance.barTintColor = BrandColours.secondary
        tabBarAppereance.tintColor = BrandColours.primary
        
        var textfieldApperance = UITextField.appearance()
        textfieldApperance.tintColor = .black
        
        // Setup Font Here (http://stackoverflow.com/questions/28180449/using-custom-font-for-entire-ios-app-swift)
        //        UILabel.appearance().substituteFontName = "Avenir Next"
        //        UITextView.appearance().substituteFontName = "Avenir Next"
        //        UITextField.appearance().substituteFontName = "Avenir Next"
        //        UIButton.appearance().substituteFontName = "Avenir Next"
    }

}
