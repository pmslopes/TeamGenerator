//
//  PlayerListViewController+UITableViewDelegate.swift
//  TeamGenerator
//
//  Created by CTW00169 on 09/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

extension PlayerListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerDetailsViewController = PlayerDetailsViewController(nibName: "PlayerDetailsViewController", bundle: nil)
        playerDetailsViewController.viewModel = viewModel?.players.value[indexPath.row]
        
        playerDetailsViewController.playerClosure = { [unowned self] playerViewModel, viewController in
            self.viewModel?.update(playerViewModel: playerViewModel, completion: { (player, error) in
                viewController.navigationController?.popViewController(animated: true)
            })
        }
        
        navigationController?.pushViewController(playerDetailsViewController, animated: true)
    }
}
