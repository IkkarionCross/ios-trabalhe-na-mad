//
//  PullsRequestDAO.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 16/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import Foundation
import CoreData

class PullsRequestDAO : NSObject
{
    private var dataContext: NSManagedObjectContext
    
    init(withContext: NSManagedObjectContext) {
        dataContext = withContext
    }
    func insertAll(pulls: [GitPullRequest], forProject: GitProject)
    {
        let context = dataContext
        
        for pull in pulls {
            let ownerEntity = NSEntityDescription.entity(forEntityName: "ProjectOwner", in: context)
            let owner  = NSManagedObject(entity: ownerEntity!, insertInto: context)
            
            owner.setValue(pull.user?.id         , forKey: "id"         )
            owner.setValue(pull.user?.login      , forKey: "login"      )
            owner.setValue(pull.user?.picture_url, forKey: "picture_url")
            
            let prEntity     = NSEntityDescription.entity(forEntityName: "PullsRequest", in: context)
            let pullRequest  = NSManagedObject(entity: prEntity!, insertInto: context)
            
            pullRequest.setValue(pull.id      , forKey: "id"          )
            pullRequest.setValue(pull.date    , forKey: "created_date")
            pullRequest.setValue(pull.title   , forKey: "title"       )
            pullRequest.setValue(pull.body    , forKey: "body"        )
            pullRequest.setValue(pull.htmlUrl , forKey: "html_url"    )
            
            
            pullRequest.setValue(owner     , forKey: "user")
            pullRequest.setValue(forProject, forKey: "project")
        }
        
        self.saveContext()
    }
    
    func getAllPulls(forProjectID: Int16) throws -> [PullsRequest]
    {
        let predicate:NSPredicate = NSPredicate(format: "project.id = %d", forProjectID)
        let fetchProjects:NSFetchRequest<PullsRequest> = PullsRequest.fetchRequest()
        fetchProjects.predicate = predicate
        
        return try dataContext.fetch(fetchProjects) as [PullsRequest]
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
