//
//  PlayerViewController.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 18/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var strengthTextField: UITextField!
    @IBOutlet weak var belongsToClubSwitch: UISwitch!
    
    var viewModel: PlayerViewModel? {
        didSet {
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        // Do any additional setup after loading the view.
        styleUI()
        fillUI()
    }
    
    @IBAction func save() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.save(name: nameTextField.text!, strength: strengthTextField.text!, belongsToClub: belongsToClubSwitch.isOn)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private
    fileprivate func styleUI() {

    }
    
    fileprivate func fillUI() {
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        nameTextField.text = viewModel.playerName
        strengthTextField.text = viewModel.playerStrength
        belongsToClubSwitch.isOn = viewModel.playerBelongsToClub
    }
}
