//
//  ProductTableCell.swift
//  SprotStore
//
//  Created by nguyen hula on 2/19/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell {

    @IBOutlet weak var stockField: UITextField!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var nameLabel: UILabel!
    
    var product : Product?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
