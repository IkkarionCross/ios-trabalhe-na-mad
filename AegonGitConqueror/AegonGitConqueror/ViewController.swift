//
//  ViewController.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 14/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Alamofire_Gloss

class ViewController: UIViewController {
    
    @IBOutlet var name:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.dataController.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ProjectOwner", in: managedContext)
        let owner = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        owner.setValue(0, forKey: "id");
        owner.setValue("teste", forKey: "login")
        
        appDelegate.saveContext()
        
        
        let fetchOwners:NSFetchRequest<ProjectOwner> = ProjectOwner.fetchRequest()
        
        do {
            
            let ownersFetched = try managedContext.fetch(fetchOwners)
            let owner = ownersFetched.first
            
            self.name?.text = owner?.login
            
        } catch  {
            print(error)
        }
        
        Alamofire.request("https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1").responseObject(RepositoriesData.self) { (response) in
            switch response.result
            {
            case .success(let repositories):
                print("\(repositories)")
            case .failure(let error):
                print("\(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

