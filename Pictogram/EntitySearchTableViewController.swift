//
//  SearchTableViewController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 13/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

protocol EntitySearchDelegate {
    func didSelectValue(entity: Entity) -> Void
}

class EntitySearchTableViewController: UITableViewController {
    
    var entities = [Entity]()
    var filteredEntities = [Entity]()
    let searchController = UISearchController(searchResultsController: nil)
    var delegate: EntitySearchDelegate? {
        didSet {
            print("delegate set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false

        
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        searchController.searchBar.scopeButtonTitles = ["Course", "University"]
        
        fetchEntity()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEntities.count
        }
        return entities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var entity : Entity
        if searchController.isActive && searchController.searchBar.text != "" {
            entity = filteredEntities[indexPath.item]
        }else {
            entity = entities[indexPath.item]
        }
        
        cell.textLabel?.text = entity.name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntity = entities[indexPath.item]
        self.delegate?.didSelectValue(entity: selectedEntity)
        navigationController?.popViewController(animated: true)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String) {
        filteredEntities = entities.filter({( entity : Entity) -> Bool in
            let categoryMatch = (entity.type.rawValue == scope)
            return categoryMatch && entity.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    fileprivate func fetchEntity() {
        print("fetching entity")
        DaoManager.shared.fetchMetadata(model: "universities") { (err, result) in
            if err != nil {
                print("Failed to fetch", err)
            }
            
            self.entities = result
            self.tableView.reloadData()
            print(result)
        }
    }

  
}

extension EntitySearchTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("scope is \(selectedScope)")
    }
}

extension EntitySearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("inside updater thing")
    }
}

struct Entity {
    var name : String
    var type: EntityType
    
    init(dictionary:[String:Any], type: EntityType) {
        self.name = dictionary["name"] as? String ?? ""
        self.type = type
    }
}


enum EntityType : String {
    case University = "Univeristy"
}
