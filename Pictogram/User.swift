//
//  User.swift
//  Pictogram
//
//  Created by mac on 4/6/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import Foundation


struct User {
    let username: String
    let profileImageUrl: String
    let dictionary: [String:Any]
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        self.username = dictionary[UserAttributes.username.rawValue] as? String ?? ""
        self.profileImageUrl = dictionary[UserAttributes.profileImageUrl.rawValue] as? String ?? ""
    }
    
    func getValues() -> [String]{
        //for use in user profile
        return [self.username, self.profileImageUrl]
    }
}

enum UserAttributes : String {
    case username = "username"
    case profileImageUrl = "profileImageUrl"
}
