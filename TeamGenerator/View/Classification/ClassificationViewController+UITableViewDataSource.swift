//
//  ClassificationViewController+UITableViewDataSource.swift
//  TeamGenerator
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

extension ClassificationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.players.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ClassificationTableViewCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        
        let playerViewModel = viewModel!.players.value[indexPath.row]
        
        cell.nameLabel.text = playerViewModel.playerName
        cell.winPercentageLabel.text = playerViewModel.playerWinPercentage
        
        return cell
    }
}
