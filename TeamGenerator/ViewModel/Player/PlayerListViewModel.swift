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
    
    func add(name: String, strength: Int, belongsToClub: Bool)
    func delete(indexPath: IndexPath)
}

class PlayerListViewModelFromPlayers: NSObject, PlayerListViewModel {
    
    var databasePlayerLibrary: PlayerLibrary?
    
    // MARK: PlayerViewModel protocol
    var players: Dynamic<[PlayerViewModel]> = Dynamic([])
    
    // MARK: Init
    override init() {
        super.init()
        
        databasePlayerLibrary = DatabasePlayerLibrary()
        
        databasePlayerLibrary?.fetch { (playerList) in
            for player in playerList {
                let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
                self.players.value.append(playerViewModel)
            }
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addedPlayer(_:)),
                                               name: NSNotification.Name(rawValue: PlayerLibraryNotifications.PlayerLibraryPlayerAdded),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removedPlayer(_:)),
                                               name: NSNotification.Name(rawValue: PlayerLibraryNotifications.PlayerLibraryPlayerRemoved),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func add(name: String, strength: Int, belongsToClub: Bool) {
        let player = Player(uid: players.value.count, name: name, strength: strength, belongsToClub: belongsToClub)
        databasePlayerLibrary?.add(player)
    }
    
    func delete(indexPath: IndexPath) {
        databasePlayerLibrary?.remove(indexPath.row)
    }
    
    // MARK: Notifications
    @objc func addedPlayer(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, let player = userInfo["player"] as! Player? else {
            return
        }
        
        let playerViewModel = PlayerViewModelFromPlayer(withPlayer: player)
        players.value.append(playerViewModel)
    }
    
    @objc func removedPlayer(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, let playerIndex = userInfo["playerIndex"] as! Int? else {
            return
        }

        players.value.remove(at: playerIndex)
    }
}
