//
//  GitHuApiDelegate.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import Foundation


protocol GitApiRepositoriesDelegate {
    
    
    func receiveRepositories(forPage:Int, repositories: RepositoriesData)
    func apiRequestError(error: Error)
    
}
