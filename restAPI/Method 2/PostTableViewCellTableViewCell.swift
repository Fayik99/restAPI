//
//  PostTableViewCellTableViewCell.swift
//  restAPI
//
//  Created by Fayik Muzammil on 8/3/20.
//  Copyright © 2020 Fayik Muzammil. All rights reserved.
//

import UIKit

class PostTableViewCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    @IBOutlet weak var userName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    @IBAction func getAllPostByUser(_ sender: Any) {
        
    }
    
}
