//
//  PlayerListViewController.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 06/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class PlayerListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PlayerListViewModel? {
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
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
        
        tableView.register(cellClass: PlayerTableViewCell.self)
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
    
    @objc func addTapped() {
        let playerDetailsViewController = PlayerDetailsViewController(nibName: "PlayerDetailsViewController", bundle: nil)
        playerDetailsViewController.viewModel = PlayerViewModelFromPlayer(withPlayer: nil)
        playerDetailsViewController.playerClosure = { [unowned self] playerViewModel, viewController in
            self.viewModel?.add(playerViewModel: playerViewModel, completion: { (player) in
                viewController.navigationController?.popViewController(animated: true)
            })
        }
        
        navigationController?.pushViewController(playerDetailsViewController, animated: true)
    }
}
