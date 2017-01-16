//
//  PullsRequestListController.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit
import CoreData

class PullsRequestListController: UITableViewController, GitApiPullsDelegate {
    
    var repository:GitProject?
    
    private var pullsRequests:[PullsRequest]!
    
    private var appDelegate: AppDelegate!
    private var dataContext: NSManagedObjectContext!
    private var pullsDao   : PullsRequestDAO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "PullsRequests"
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.dataContext = self.appDelegate.dataController.managedObjectContext
        
        self.pullsDao = PullsRequestDAO(withContext: dataContext)
        
        let nib = UINib(nibName: "PullsRequestCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "pullCell")
        
        if let project = self.repository
        {
            if ((project.pulls?.count)! > 0) // check if it is already in the repository
            {
                self.pullsRequests = project.pulls?.allObjects as? [PullsRequest]
            }
            else
            {
                GitHubApi.shared.getPullsRequests(withRepoFullName: project.full_name!, apiDelegate: self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPullsRequests()
    {
        do
        {
            self.pullsRequests = try self.pullsDao.getAllPulls(forProjectID: (self.repository?.id)!)
            
            self.tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    func receivePullsRequest(pulls: [GitPullRequest]) {
        self.pullsDao.insertAll(pulls: pulls, forProject: self.repository!)
        
        self.loadPullsRequests()
    }
    
    func apiRequestError(error: Error) {
        let alert:UIAlertController = UIAlertController(title: "Desculpe...", message: "Um erro ocorreu ao tentar consultar o GitHub. Verifique sua conexão com a internet", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        print(error)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (self.pullsRequests == nil)
        {
            return 0
        }
        return self.pullsRequests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pullCell", for: indexPath)

        if let pullCell = cell as? PullsRequestCell
        {
            pullCell.fillWith(pull: self.pullsRequests[indexPath.row])
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pullRequest:PullsRequest = pullsRequests[indexPath.row]
        let url:URL = URL(string: pullRequest.html_url!)!
        
        UIApplication.shared.openURL(url)
    }
    
    


}
