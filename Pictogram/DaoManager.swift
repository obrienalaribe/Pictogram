//
//  DaoManager.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 10/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

class DaoManager {
    
    static let shared = DaoManager()
    
    func fetchCollections(model: String, completionHandler: @escaping (_ error: Error?, _ dictionary: [String: Any]) -> ()) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
            let ref = FIRDatabase.database().reference().child(model).child(uid)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionaries = snapshot.value as? [String: Any] else {return}
                
                dictionaries.forEach({ (key, value) in
                    //                print("Key \(key), Value: \(value)")
                    
                    guard let dictionary = value as? [String:Any] else {return}
                    
                    completionHandler(nil, dictionary)
                    
                })
                
            }) { (err) in
                completionHandler(err, [:])
                print("Failed to fetch generic collection from DB")
            }
            
        }
    
    
    
    func fetchMetadata(model: String, completionHandler: @escaping (_ error: Error?, _ result: [Entity]) -> ()) {
        let ref = FIRDatabase.database().reference().child(model)
        var entities = [Entity]()
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                                print("Key \(key), Value: \(value)")
                
                guard let dictionary = value as? [String:Any] else {return}
                
                
                let entity = Entity(dictionary: dictionary, type: .University)
                
                entities.append(entity)
                
            })
            
            completionHandler(nil, entities)

            
        }) { (err) in
            completionHandler(err, [Entity]())
            print("Failed to fetch generic collection for \(model) from DB")
        }
        
    }
  }
