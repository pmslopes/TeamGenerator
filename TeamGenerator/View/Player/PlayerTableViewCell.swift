//
//  PlayerTableViewCell.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
