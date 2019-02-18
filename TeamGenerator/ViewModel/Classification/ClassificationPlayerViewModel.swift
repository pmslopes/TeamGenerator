//
//  ClassificationPlayerViewModel.swift
//  TeamGenerator
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol ClassificationPlayerViewModel {
    var playerName: String { get }
    var playerWinPercentage: String { get }
}

class ClassificationPlayerViewModelFromPlayer: NSObject, ClassificationPlayerViewModel {
    // MARK: PlayerViewModel protocol
    var playerName: String = ""
    var playerWinPercentage: String = ""
    
    var player: Player?
    
    // MARK: Init
    init(withPlayer player: Player?) {
        super.init()
        
        self.player = player
        
        if let player = player {
            playerName = player.name
            playerWinPercentage = "\(player.winPercentage)%"
        }
    }
}
