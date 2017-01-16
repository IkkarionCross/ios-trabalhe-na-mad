//
//  PersistenceManager.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import CoreData
import UIKit

class PersistenceManager: NSObject {
    
    static let shared = PersistenceManager()
    
    
    func syncWithCoreData(repositories: RepositoriesData, forPage: Int)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.dataController.managedObjectContext
        
        for repo in repositories.items! {
            let ownerEntity = NSEntityDescription.entity(forEntityName: "ProjectOwner", in: context)
            let owner  = NSManagedObject(entity: ownerEntity!, insertInto: context)
            
            owner.setValue(repo.owner?.id, forKey: "id")
            owner.setValue(repo.owner?.login, forKey: "login")
            owner.setValue(repo.owner?.picture_url, forKey: "picture_url")
            
            let projectEntity  = NSEntityDescription.entity(forEntityName: "GitProject", in: context)
            let project = NSManagedObject(entity: projectEntity!, insertInto: context)
            
            project.setValue(repo.id      , forKey: "id")
            project.setValue(repo.desc    , forKey: "desc")
            project.setValue(repo.fullName, forKey: "full_name")
            project.setValue(repo.name    , forKey: "name")
            project.setValue(repo.forks   , forKey: "forks")
            project.setValue(repo.stars   , forKey: "stars")
            project.setValue(repo.watchers, forKey: "watchers")
            project.setValue(forPage      , forKey: "page")
            
            project.setValue(owner, forKey: "ownerone")
            
            
            
        }
        
        appDelegate.saveContext()
    }
    
    func syncWithCoreData(pulls: [GitPullRequest], forProject: GitProject)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.dataController.managedObjectContext
        
        for pull in pulls {
            let ownerEntity = NSEntityDescription.entity(forEntityName: "ProjectOwner", in: context)
            let owner  = NSManagedObject(entity: ownerEntity!, insertInto: context)
            
            owner.setValue(pull.user?.id, forKey: "id")
            owner.setValue(pull.user?.login, forKey: "login")
            owner.setValue(pull.user?.picture_url, forKey: "picture_url")
            
            let prEntity     = NSEntityDescription.entity(forEntityName: "PullsRequest", in: context)
            let pullRequest  = NSManagedObject(entity: prEntity!, insertInto: context)
            
            pullRequest.setValue(pull.id      , forKey: "id")
            pullRequest.setValue(pull.date    , forKey: "created_date")
            pullRequest.setValue(pull.title   , forKey: "title")
            pullRequest.setValue(pull.body    , forKey: "body")
  
            
            pullRequest.setValue(owner     , forKey: "user")
            pullRequest.setValue(forProject, forKey: "project")
        }
        
        appDelegate.saveContext()
    }
    
    
    func isSyncronized(page:Int) -> Bool
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let predicate:NSPredicate = NSPredicate(format: "page = %@", String(page))
        let fetchProjects:NSFetchRequest<GitProject> = GitProject.fetchRequest()
        fetchProjects.predicate = predicate;
        
        do
        {
            let projects = try appDelegate.dataController.managedObjectContext.fetch(fetchProjects)
            
            return projects.count > 0
        }
        catch
        {
            print(error)
        }
        
        return false;
    }
    

}
