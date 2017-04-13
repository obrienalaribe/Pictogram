//
//  DataFactory.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 13/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import FirebaseDatabase


class DataFactory {
    
    static let shared = DataFactory()
    
    func persistMetaData(model: String, values: [String:Any]){
        let userPostRef = FIRDatabase.database().reference().child(model)
        
        let ref = userPostRef.childByAutoId()

        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save METADATA to DB")
                return
            }
            
            print("Successfully saved METADATA to DB")
        }
        
    }
    

}
