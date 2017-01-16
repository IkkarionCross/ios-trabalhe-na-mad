//
//  RepositoryCell.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    
    @IBOutlet var txtName       :UILabel?
    @IBOutlet var txtDescription:UILabel?
    @IBOutlet var txtLang       :UILabel?
    @IBOutlet var txtStars      :UILabel?
    @IBOutlet var txtForks      :UILabel?
    
    
    var project:GitProject!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    public func fillWith(project: GitProject)
    {
        self.project = project
        
        self.txtName?.text        = project.full_name
        self.txtDescription?.text = project.desc
        self.txtLang?.text        = "Swift"
        self.txtStars?.text       = String(project.stars)
        self.txtForks?.text       = String(project.forks)
    }
    
}
