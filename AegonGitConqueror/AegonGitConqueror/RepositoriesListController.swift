//
//  RepositoriesListController.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit
import CoreData

class RepositoriesListController: UITableViewController, GitApiRepositoriesDelegate {
    
    private var projects   : [GitProject]!
    private var currentPage: Int = 1
    private var updatingRepositories: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "RepositoryCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "repoCell")
        
        self.projects = [GitProject]()
        syncProjects()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.projects == nil)
        {
            return 0
        }
        
        return self.projects.count
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? PullsRequestListController
        {
            destinationController.repositoryFullName = sender as? String
        }
    }
    
    func syncProjects()
    {
        updatingRepositories = true
        if (!PersistenceManager.shared.isSyncronized(page: currentPage))
        {
            GitHubApi.shared.getRepositories(withPage: currentPage, apiDelegate: self)
        }
        else
        {
            loadRepositoriesFromCache(forPage: currentPage)
        }
    }
    
    func loadRepositoriesFromCache(forPage:Int)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let predicate = NSPredicate(format: "page = %@", String(forPage))
        let sortDescriptor = NSSortDescriptor(key: "stars", ascending: false)
        let fetchProjects:NSFetchRequest<GitProject> = GitProject.fetchRequest()
        fetchProjects.predicate = predicate
        fetchProjects.sortDescriptors = [sortDescriptor]
        
        do
        {
            let fetchedProjects = try appDelegate.dataController.managedObjectContext.fetch(fetchProjects) as [GitProject]
            
            self.projects.append(contentsOf: fetchedProjects)
            
            self.tableView.reloadData()
            
            updatingRepositories = false
        }
        catch {
            print(error)
        }
    }
    
    
    func receiveRepositories(forPage:Int, repositories: RepositoriesData) {
        
        PersistenceManager.shared.syncWithCoreData(repositories: repositories, forPage: forPage)
        
        loadRepositoriesFromCache(forPage: forPage)
    }
    
    func apiRequestError(error: Error) {
        let alert:UIAlertController = UIAlertController(title: "Desculpe...", message: "Um erro ocorreu ao tentar consultar o GitHub. Verifique sua conexão com a internet", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        print(error)
        
        updatingRepositories = false
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        
        if let repoCell = cell as? RepositoryCell
        {
            repoCell.fillWith(project: self.projects[indexPath.row])
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = self.projects[indexPath.row]
        
        self.performSegue(withIdentifier: "showPullRequests", sender: project.full_name)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // how much the user has to pull the end
        // of the list for it be updated
        let pullDisplacement:CGFloat = 600
        
        let currentPos  = scrollView.contentOffset.y
        let totalHeight = scrollView.contentSize.height - (pullDisplacement)
        
        if (currentPos >= totalHeight &&
            !updatingRepositories)
        {
            currentPage += 1
            print(currentPage)
            syncProjects()
        }
    }
    
    
    

}
