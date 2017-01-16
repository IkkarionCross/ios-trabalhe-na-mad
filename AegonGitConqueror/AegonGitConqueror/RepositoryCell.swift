//
//  RepositoryCell.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    
    @IBOutlet var lblName       :UILabel?
    @IBOutlet var lblDescription:UILabel?
    @IBOutlet var lblLang       :UILabel?
    @IBOutlet var lblStars      :UILabel?
    @IBOutlet var lblForks      :UILabel?
    @IBOutlet var lblOwnerName  :UILabel?
    @IBOutlet var ivOwnerPicture:UIImageView?
    
    
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
        
        self.lblOwnerName?.text   = project.ownerone?.login
        self.lblName?.text        = project.full_name
        self.lblDescription?.text = project.desc
        self.lblLang?.text        = "Swift"
        self.lblStars?.text       = String(project.stars)
        self.lblForks?.text       = String(project.forks)
        
        
        self.ivOwnerPicture?.downloadedFrom(link: (project.ownerone?.picture_url)!)
    }
    
}
