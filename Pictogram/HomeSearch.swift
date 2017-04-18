//
//  HomeSearch.swift
//  Pictogram
//
//  Created by mac on 4/18/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

extension HomeController {


}
extension HomeController : UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       deactivateSearch()
    }
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // we used here to set self.searchBarActive = YES
        // but we'll not do that any more... it made problems
        // it's better to set self.searchBarActive = YES when user typed something
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // this method is being called when search btn in the keyboard tapped
        // we set searchBarActive = NO
        // but no need to reloadCollectionView
        self.searchBar.setShowsCancelButton(false, animated: false)
    }

}
