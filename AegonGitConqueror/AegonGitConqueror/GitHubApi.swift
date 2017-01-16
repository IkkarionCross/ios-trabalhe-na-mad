//
//  GitHubApi.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import Alamofire
import Alamofire_Gloss

class GitHubApi: NSObject {
    
    
    static let shared = GitHubApi()
    
    let URL_REPO  = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page="
    let URL_PULLS = "https://api.github.com/repos/FULLNAME/pulls"
    
    private override init() {
        
    }
    
    
    func getRepositories(withPage: Int, apiDelegate: GitApiRepositoriesDelegate)
    {
        var url:String = URL_REPO
        url = url.appending(String(withPage))
        
        Alamofire.request(url).responseObject(RepositoriesData.self) { (response) in
            switch response.result
            {
            case .success(let repositories):
                apiDelegate.receiveRepositories(forPage: withPage, repositories: repositories)
            case .failure(let error):
                apiDelegate.apiRequestError(error: error)
            }

        }
    }
    
    
    func getPullsRequests(withRepoFullName: String, apiDelegate: GitApiPullsDelegate)
    {
        var url = URL_PULLS
        url = url.replacingOccurrences(of: "FULLNAME", with: withRepoFullName)
        
        Alamofire.request(url).responseArray(GitPullRequest.self, completionHandler: { (response) in
            switch response.result
            {
            case .success(let pulls):
                apiDelegate.receivePullsRequest(pulls: pulls)
            case .failure(let error):
                apiDelegate.apiRequestError(error: error)
            }
        })
    }
}
