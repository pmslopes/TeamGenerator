//
//  PlayerListViewController+UITableViewDataSource.swift
//  TeamGenerator
//
//  Created by CTW00169 on 08/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.delete(indexPath: indexPath, completion: nil)
        }
    }
}
