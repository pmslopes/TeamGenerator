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
    
    @IBAction func addPlayer() {
        guard let viewModel = viewModel else {
            return
        }
        
        let viewController = PlayerViewController()
        viewController.viewModel = AddPlayerViewModel(numberOfPlayers: viewModel.players.value.count)
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: Private
    fileprivate func styleUI() {        
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
}

extension PlayerListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.players.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerTableViewCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        
        let playerViewModel = viewModel!.players.value[indexPath.row]
        
        cell.nameLabel.text = playerViewModel.playerName
        cell.strengthLabel.text = playerViewModel.playerStrength
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.delete(indexPath: indexPath)
        }
    }
}

extension PlayerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }

        let viewController = PlayerViewController()
        viewController.viewModel = viewModel.players.value[indexPath.row]
        present(viewController, animated: true, completion: nil)
    }
}

