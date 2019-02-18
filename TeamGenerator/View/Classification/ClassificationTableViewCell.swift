//
//  ClassificationTableViewCell.swift
//  TeamGenerator
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class ClassificationTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var winPercentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

