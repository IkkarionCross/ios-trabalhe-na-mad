//
//  GitApiPullsDelegate.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit

protocol GitApiPullsDelegate {
    func receivePullsRequest(pulls: [GitPullRequest])
    func apiRequestError(error: Error)

}
