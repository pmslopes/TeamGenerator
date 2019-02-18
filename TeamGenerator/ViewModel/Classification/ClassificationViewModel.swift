//
//  ClassificationViewModel.swift
//  TeamGenerator
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol ClassificationViewModel {
    var players: Dynamic<[ClassificationPlayerViewModel]> { get }
    
    func fetch(completion: (([Player]) -> Void)?)
}

class ClassificationViewModelFromPlayers: NSObject, ClassificationViewModel {
    var playerLibrary: PlayerLibrary?
    
    // MARK: PlayerViewModel protocol
    var players: Dynamic<[ClassificationPlayerViewModel]> = Dynamic([])
    
    // MARK: Init
    init(playerLibrary: PlayerLibrary?) {
        super.init()
        
        self.playerLibrary = playerLibrary
    }
    
    func fetch(completion: (([Player]) -> Void)?) {
        // Clean up players
        players.value.removeAll()
        
        playerLibrary?.fetch { [weak self] (players) in
            // Sort players by win percentage
            let sortedPlayers = players.sorted(by: { (playerA, playerB) -> Bool in
                return playerA.winPercentage > playerB.winPercentage
            })
            
            for player in sortedPlayers {
                let playerViewModel = ClassificationPlayerViewModelFromPlayer(withPlayer: player)
                self?.players.value.append(playerViewModel)
            }
            
            completion?(players)
        }
    }
}
