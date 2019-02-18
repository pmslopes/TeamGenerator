//
//  PlayerDetailView.swift
//  TeamGenerator
//
//  Created by CTW00169 on 09/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class PlayerDetailView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    func heightConstraint() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                 attribute: .height,
                                 relatedBy: .equal,
                                 toItem: nil,
                                 attribute: .notAnAttribute,
                                 multiplier: 1,
                                 constant: 68)
    }
    
    func value() -> String {
        return textField.text!
    }
}
