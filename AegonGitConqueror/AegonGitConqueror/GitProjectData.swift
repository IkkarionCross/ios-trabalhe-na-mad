//
//  GitProjectData.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 14/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import Gloss

struct GitProjectData: Decodable {
    let id      :Int?
    let forks   :Int?
    let stars   :Int?
    let watchers:Int?
    let fullName:String?
    let desc    :String?
    let name    :String?
    let owner   : ProjectOwnerData?
    
    
    
    init?(json: JSON) {
        self.id       = "id"               <~~ json
        self.desc     = "description"      <~~ json
        self.forks    = "forks_count"      <~~ json
        self.watchers = "watchers_count"   <~~ json
        self.stars    = "stargazers_count" <~~ json
        self.fullName = "full_name"        <~~ json
        self.name     = "name"             <~~ json
        
        self.owner    = ProjectOwnerData(json: ("owner" <~~ json)!)
        
    }

}
