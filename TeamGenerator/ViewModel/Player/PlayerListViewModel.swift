//
//  PlayerListViewModelFromPlayers.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

protocol PlayerListViewModel {
    var players: Dynamic<[PlayerViewModel]> { get }
    
    func fetch(completion: (([Player]) -> Void)?)
    func add(playerViewModel: PlayerViewModel, completion: ((Player) -> Void)?)
    func update(playerViewModel: PlayerViewModel, completion: @escaping ((Player?, String?) -> Void))
    func delete(indexPath: IndexPath, completion: ((Player) -> Void)?)
}

class PlayerListViewModelFromPlayers: NSObject, PlayerListViewModel {
    var playerLibrary: PlayerLibrary?
    
    // MARK: PlayerViewModel protocol
    var players: Dynamic<[PlayerViewModel]> = Dynamic([])
    
    // MARK: Init
    init(playerLibrary: PlayerLibrary?) {
        super.init()
        
        self.playerLibrary = playerLibrary
    }
    
    func fetch(completion: (([Player]) -> Void)?) {
        // Clean up players
        players.value.removeAll()
        
        playerLibrary?.fetch { [weak self] (players) in
            for player in players {
                let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
                self?.players.value.append(playerViewModel)
            }
            completion?(players)
        }
    }
    
    func add(playerViewModel: PlayerViewModel, completion: ((Player) -> Void)?) {
        var playerUid = 0
        
        if let lastPlayer = playerLibrary?.players?.last {
            playerUid = lastPlayer.uid + 1
        }
        
        let player = Player(uid: playerUid,
                            name: playerViewModel.playerName,
                            number: Int(playerViewModel.playerNumber),
                            strength: Int(playerViewModel.playerStrength)!,
                            belongsToClub: true)
        
        playerLibrary?.add(player) { [weak self] player in
            let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
            self?.players.value.append(playerViewModel)
            completion?(player)
        }
    }
    
    func update(playerViewModel: PlayerViewModel, completion: @escaping ((Player?, String?) -> Void)) {
        playerLibrary?.fetch(id: playerViewModel.playerId, completion: { [unowned self] (player) in
            guard var player = player else {
                completion(nil, "Error")
                return
            }
            
            player.name = playerViewModel.playerName
            player.strength = Int(playerViewModel.playerStrength)!
            
            if playerViewModel.playerNumber.count > 0 {
                if let playerNumber = Int(playerViewModel.playerNumber)  {
                    player.number = playerNumber
                }
            }
            
            self.playerLibrary?.update(player, completion: { (player) in
                completion(player, nil)
            })
        })
    }
    
    func delete(indexPath: IndexPath, completion: ((Player) -> Void)? = { player in }) {
        playerLibrary?.remove(indexPath.row) { [weak self] player in
            self?.players.value.remove(at: indexPath.row)
            completion?(player)
        }
    }
}
