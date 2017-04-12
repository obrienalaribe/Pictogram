//
//  CollectionViewController.swift
//  Pictogram
//
//  Created by mac on 4/12/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UISearchBarDelegate {
    var dataSource:[String]?
    var dataSourceForSearchResult:[String]?
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var searchBar:UISearchBar?
    var refreshControl:UIRefreshControl?
    let reuseIdentifier:String = "Cell"
    
    override func viewDidLoad() {
        
        self.dataSource = ["Modesto","Rebecka","Andria","Sergio","Robby","Jacob","Lavera", "Theola", "Adella","Garry", "Lawanda", "Christiana", "Billy", "Claretta", "Gina", "Edna", "Antoinette", "Shantae", "Jeniffer", "Fred", "Phylis", "Raymon", "Brenna", "Gulfs", "Ethan", "Kimbery", "Sunday", "Darrin", "Ruby", "Babette", "Latrisha", "Dewey", "Della", "Dylan", "Francina", "Boyd", "Willette", "Mitsuko", "Evan", "Dagmar", "Cecille", "Doug",
                           "Jackeline", "Yolanda", "Patsy", "Haley", "Isaura", "Tommye", "Katherine", "Vivian"]
        
        self.dataSourceForSearchResult = [String]()
        
        collectionView?.register(CCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareUI()
    }
    
    deinit{
        self.removeObservers()
    }
    // MARK: actions
    func refreashControlAction(){
        self.cancelSearching()
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // stop refreshing after 2 seconds
            self.collectionView?.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
    }
    
    
    // MARK: <UICollectionViewDataSource>
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBarActive {
            return self.dataSourceForSearchResult!.count;
        }
        return self.dataSource!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CCell
        
        if (self.searchBarActive) {
            cell.userInfo.text = self.dataSourceForSearchResult![indexPath.row];
        }else{
            cell.userInfo.text = self.dataSource![indexPath.row];
        }
        
        return cell
    }
    
    
    // MARK: <UICollectionViewDelegateFlowLayout>
    func collectionView( collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(self.searchBar!.frame.size.height, 0, 0, 0);
    }
    func collectionView (collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let cellLeg = (collectionView.frame.size.width/2) - 5;
        return CGSize(width: cellLeg, height: cellLeg)
    }
    
    
    // MARK: Search
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.dataSource?.filter({ (text:String) -> Bool in
            return text.contains(searchText)
        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        if searchText.characters.count > 0 {
            // search and reload data source
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText: searchText)
            self.collectionView?.reloadData()
        }else{
            // if text lenght == 0
            // we will consider the searchbar is not active
            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self .cancelSearching()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        // we used here to set self.searchBarActive = YES
        // but we'll not do that any more... it made problems
        // it's better to set self.searchBarActive = YES when user typed something
        self.searchBar!.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        // this method is being called when search btn in the keyboard tapped
        // we set searchBarActive = NO
        // but no need to reloadCollectionView
        self.searchBarActive = false
        self.searchBar!.setShowsCancelButton(false, animated: false)
    }
    func cancelSearching(){
        self.searchBarActive = false
        self.searchBar!.resignFirstResponder()
        self.searchBar!.text = ""
    }
    
    // MARK: prepareVC
    func prepareUI(){
        self.addSearchBar()
        self.addRefreshControl()
    }
    
    func addSearchBar(){
        if self.searchBar == nil{
            self.searchBarBoundsY = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height
            
            self.searchBar = UISearchBar(frame: CGRect(x: 0, y: self.searchBarBoundsY!, width: view.frame.width, height: 44))
                
         
            self.searchBar!.searchBarStyle = UISearchBarStyle.minimal
            self.searchBar!.tintColor = UIColor.white
      self.searchBar!.barTintColor  = UIColor.white
            self.searchBar!.delegate = self;
            self.searchBar!.placeholder = "search here";
            
            self.addObservers()
        }
        
        if !self.searchBar!.isDescendant(of: self.view){
            self.view .addSubview(self.searchBar!)
        }
    }
    
    func addRefreshControl(){
        if (self.refreshControl == nil) {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.tintColor = UIColor.white
            self.refreshControl?.addTarget(self, action: #selector(SearchViewController.refreashControlAction), for: UIControlEvents.valueChanged)
        }
        if !self.refreshControl!.isDescendant(of: self.collectionView!) {
            self.collectionView!.addSubview(self.refreshControl!)
        }
    }
    
    func startRefreshControl(){
        if !self.refreshControl!.isRefreshing {
            self.refreshControl!.beginRefreshing()
        }
    }
    
    func addObservers(){
        let context = UnsafeMutablePointer<UInt8>(bitPattern: 1)
        self.collectionView?.addObserver(self, forKeyPath: "contentOffset", options: [.new,.old], context: context)
    }
    
    func removeObservers(){
        self.collectionView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       
        if keyPath! == "contentOffset" {
            if let collectionV:UICollectionView = object as? UICollectionView {
                self.searchBar?.frame = CGRect(x: self.searchBar!.frame.origin.x, y: self.searchBarBoundsY! + ( (-1 * collectionV.contentOffset.y) - self.searchBarBoundsY!), width:  self.searchBar!.frame.size.width, height: self.searchBar!.frame.size.height)
            }
        }

    }

}


class CCell: UICollectionViewCell {
        
    
        let userInfo : UILabel = {
            let label = UILabel()
            let attributedText = NSMutableAttributedString(string: "obrienalaribe \n", attributes: [NSForegroundColorAttributeName:  UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)] )
            
            attributedText.append(NSAttributedString(string: "University of Leeds", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 10)]))
            
            label.attributedText = attributedText
            label.numberOfLines = 0
            return label
        }()
        
    
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = BrandColours.secondary
            
            addSubview(userInfo)
            userInfo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            userInfo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        }
        
    
}
