//
//  RepositoriesDAO.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 16/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import Foundation
import CoreData

class RepositoriesDAO : NSObject
{
    private var dataContext: NSManagedObjectContext
    
    init(withContext: NSManagedObjectContext) {
        self.dataContext = withContext
    }
    
    func insertAll(repositories: RepositoriesData, forPage: Int)
    {
        let context = dataContext
        
        for repo in repositories.items! {
            let ownerEntity = NSEntityDescription.entity(forEntityName: "ProjectOwner", in: context)
            let owner  = NSManagedObject(entity: ownerEntity!, insertInto: context)
            
            owner.setValue(repo.owner?.id         , forKey: "id"         )
            owner.setValue(repo.owner?.login      , forKey: "login"      )
            owner.setValue(repo.owner?.picture_url, forKey: "picture_url")
            
            let projectEntity  = NSEntityDescription.entity(forEntityName: "GitProject", in: context)
            let project = NSManagedObject(entity: projectEntity!, insertInto: context)
            
            project.setValue(repo.id      , forKey: "id"       )
            project.setValue(repo.desc    , forKey: "desc"     )
            project.setValue(repo.fullName, forKey: "full_name")
            project.setValue(repo.name    , forKey: "name"     )
            project.setValue(repo.forks   , forKey: "forks"    )
            project.setValue(repo.stars   , forKey: "stars"    )
            project.setValue(repo.watchers, forKey: "watchers" )
            project.setValue(forPage      , forKey: "page"     )
            
            project.setValue(owner, forKey: "ownerone")
            
        }
        
        self.saveContext()
    }
    
    
    func getAllRepositories(forPage: Int) throws -> [GitProject]
    {
        let predicate = NSPredicate(format: "page = %@", String(forPage))
        let sortDescriptor = NSSortDescriptor(key: "stars", ascending: false)
        let fetchProjects:NSFetchRequest<GitProject> = GitProject.fetchRequest()
        fetchProjects.predicate = predicate
        fetchProjects.sortDescriptors = [sortDescriptor]
        
        return try dataContext.fetch(fetchProjects) as [GitProject]
    }
    
    func isSyncronized(page:Int) -> Bool
    {
        
        let predicate:NSPredicate = NSPredicate(format: "page = %@", String(page))
        let fetchProjects:NSFetchRequest<GitProject> = GitProject.fetchRequest()
        fetchProjects.predicate = predicate;
        
        do
        {
            let projects = try dataContext.fetch(fetchProjects)
            
            return projects.count > 0
        }
        catch
        {
            print(error)
        }
        
        return false;
    }
    
    func saveContext () {
        let context = self.dataContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
