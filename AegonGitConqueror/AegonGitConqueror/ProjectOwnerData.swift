//
//  ProjectOwnerModel.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 14/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit
import CoreData
import Gloss

struct ProjectOwnerData: Decodable {
    
    let id: Int?
    let login: String?
    let picture_url: String?
    
    
    init?(json: JSON) {
        self.id          = "id"         <~~ json
        self.login       = "login"      <~~ json
        self.picture_url = "avatar_url" <~~ json
        
    }
    
}
