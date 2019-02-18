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
    var players: [Player]? = []
    
    var databaseReference: DatabaseReference!
    
    override init() {
        super.init()
        
        databaseReference = Database.database().reference().child("players")
    }
    
    init(database: String) {
        super.init()
        
        databaseReference = Database.database().reference().child(database)
    }
    
    func fetch(completion: @escaping (([Player]) -> Void)) {
        players = []
        
        databaseReference.observeSingleEvent(of: .value) { (snapshot) in
            if let playerObjectList = snapshot.value as? [Any] {
                for playerObject in playerObjectList {
                    if let playerJSONObject = playerObject as? [String : Any] {
                        let player = try! Player(dictionary: playerJSONObject)
                        self.players?.append(player)
                    }
                }
                completion(self.players!)
            }
        }
    }
    
    func fetch(id: Int?, completion: @escaping ((Player?) -> Void)) {
        guard let id = id else {
            completion(nil)
            return
        }
        
        let player = players?.filter({ (player) -> Bool in
            return player.uid == id
        }).first
        
        completion(player)
    }
    
    func add(_ player: Player, completion: @escaping ((Player) -> Void)) {
        do {
            let data = try player.jsonDictionary()
            databaseReference.child(String(player.uid)).setValue(data)
            players?.append(player)
            completion(player)
        }
        catch {
            
        }
    }
    
    func remove(_ playerIndex: Int, completion: @escaping ((Player) -> Void)) {
        if playerIndex < players!.count {
            let player = players!.remove(at: playerIndex)
            databaseReference.child(String(player.uid)).removeValue()
            completion(player)
        }
    }
    
    func update(_ player: Player, completion: @escaping ((Player) -> Void)) {
        do {
            let data = try player.jsonDictionary()
            databaseReference.child(String(player.uid)).setValue(data)
            completion(player)
        }
        catch {
            
        }
    }
}
