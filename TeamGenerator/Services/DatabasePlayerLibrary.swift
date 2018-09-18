//
//  DatabasePlayerLibrary.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 07/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabasePlayerLibrary: NSObject, PlayerLibrary {
    
    fileprivate var players: [Player] = []
    
    var databaseReference: FIRDatabaseReference!
    
    override init() {
        super.init()
        
        databaseReference = FIRDatabase.database().reference().child("players")
    }
    
    func fetch(completion: @escaping (([Player]) -> Void)) {
        databaseReference.observeSingleEvent(of: .value) { (snapshot) in
            if let playerObjectList = snapshot.value as? [Any] {
                for playerObject in playerObjectList {
                    if let playerJSONObject = playerObject as? [String : Any] {
                        let player = try! Player(dictionary: playerJSONObject)
                        self.players.append(player)
                    }
                }
                completion(self.players)
            }
        }
    }
    
    func add(_ player: Player) {
        do {
            let data = try player.jsonDictionary()
            databaseReference.child(String(player.uid)).setValue(data)
            players.append(player)
            NotificationCenter.default.post(notification(PlayerLibraryNotifications.PlayerLibraryPlayerAdded, player: player))
        }
        catch {
            
        }
    }
    
    func remove(_ playerIndex: Int) {
        let player = players.remove(at: playerIndex)
        databaseReference.child(String(player.uid)).removeValue()
        NotificationCenter.default.post(notification(PlayerLibraryNotifications.PlayerLibraryPlayerRemoved, playerIndex: playerIndex))
    }
    
    func update(_ player: Player) {
        var existingPlayer: Player?
        for index in 0...players.count-1 {
            let currentPlayer = players[index]
            if currentPlayer.uid == player.uid {
                existingPlayer = currentPlayer
                break
            }
        }
        
        if var existingPlayer = existingPlayer {
            existingPlayer.name = player.name
            existingPlayer.strength = player.strength
            
            NotificationCenter.default.post(notification(PlayerLibraryNotifications.PlayerLibraryPlayerUpdated, player: player))
        }
    }
        
    // MARK: Private
    fileprivate func notification(_ name: String, player: Player) -> Notification {
        let notification: Notification = Notification(name: Notification.Name(rawValue: name), object: self, userInfo: ["player" : player])
        return notification
    }
    
    fileprivate func notification(_ name: String, playerIndex: Int) -> Notification {
        let notification: Notification = Notification(name: Notification.Name(rawValue: name), object: self, userInfo: ["playerIndex" : playerIndex])
        return notification
    }
}

