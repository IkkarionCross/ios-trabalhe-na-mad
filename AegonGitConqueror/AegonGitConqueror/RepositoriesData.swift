//
//  RepositoriesData.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit
import Gloss

struct RepositoriesData: Decodable {
    let totalCount:Int?
    let incompleteResults:Bool?
    let items:[GitProjectData]?
    
    
    
    init?(json: JSON) {
        self.totalCount = "total_count" <~~ json;
        self.incompleteResults = "incomplete_results" <~~ json
        self.items = [GitProjectData].from(jsonArray: ("items" <~~ json)!)
    }
}
