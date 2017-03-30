//
//  RegisteredCompaniesViewCell.swift
//  Cosapp
//
//  Created by APPLE on 3/23/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import Cosmos
class RegisteredCompaniesViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var businessname: UILabel!
    
    
    @IBOutlet weak var rate: CosmosView!
    
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var hiddenIDlABEL: UILabel!
    
    @IBOutlet weak var viewContent: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
