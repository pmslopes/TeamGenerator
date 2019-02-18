//
//  ClassificationViewController.swift
//  TeamGenerator
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class ClassificationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ClassificationViewModel? {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel!.fetch(completion: nil)
    }
    
    // MARK: Private
    fileprivate func styleUI() {
        tableView.register(cellClass: ClassificationTableViewCell.self)
    }
    
    fileprivate func fillUI() {
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.players.bindAndFire { [unowned self] (playersViewModel) in
            self.tableView.reloadData()
        }
    }
}
