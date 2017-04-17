//
//  ProfileEditController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 13/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

private let cellId = "cellId"
private let headerId = "headerId"

class UserProfileEditController: UITableViewController {

    var fieldNames = ["Username", "Course", "University" ]
    
    var user : User? {
        didSet{
            guard let user = user else {return}
            userData = user.getValues()
            
        }
    }
    
    var userData : [String]?
    
    var selectedCell : UserProfileEditCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        userData = [String](repeating: "", count:fieldNames.count)

        navigationItem.title = "Edit Profile"
        
        
        tableView.register(UserProfileEditCell.self, forCellReuseIdentifier: cellId)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fieldNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserProfileEditCell
        
        if indexPath.item > 0 {
            cell.accessoryType = .disclosureIndicator
            cell.isTypable = false
        }
 
        // Configure the cell...
        cell.fieldName = fieldNames[indexPath.item]
        cell.fieldData = userData?[indexPath.item]
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath) as! UserProfileEditCell
        
        if selectedCell?.isTypable == false {
            view.endEditing(true)
            let viewController = EntitySearchTableViewController()
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        selectedCell?.textField.becomeFirstResponder()
    }
   
}

extension UserProfileEditController : EntitySearchDelegate {
    func didSelectValue(entity: Entity) {
        print(entity.name)
        selectedCell?.textField.text = entity.name
    }
}
