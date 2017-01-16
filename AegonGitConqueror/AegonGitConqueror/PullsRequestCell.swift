//
//  PullsRequestCell.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//

import UIKit

class PullsRequestCell: UITableViewCell {
    
    @IBOutlet var lblOwnerName   :UILabel?
    @IBOutlet var ivOwnerPicture :UIImageView?
    @IBOutlet var lblTitle       :UILabel?
    @IBOutlet var lblDate        :UILabel?
    @IBOutlet var tvBody         :UITextView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func fillWith(pull: PullsRequest)
    {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let mDate:Date = formatter.date(from: pull.created_date!)!
        
        self.lblOwnerName?.text = pull.oneowner?.login
        self.lblTitle?.text     = pull.title
        self.lblDate?.text      = formatter.string(from: mDate)
        self.tvBody?.text       = pull.body
        
    }

    
}
