//
//  GitPullRequest.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import Gloss


struct GitPullRequest: Decodable {
    
    let id     :Int?
    let title  :String?
    let date   :String?
    let body   :String?
    let user   :ProjectOwnerData?
    let htmlUrl:String?
    
    init?(json: JSON) {
        self.id      = "id" <~~ json
        self.body    = "body" <~~ json
        self.title   = "title" <~~ json
        self.date    = "created_at" <~~ json
        self.user    = ProjectOwnerData(json: ("user" <~~ json)!)
        self.htmlUrl = "html_url" <~~ json
    }
    
}
