//
//  Player.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 06/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation

struct Player: Codable {
    let uid: Int
    var name: String
    var number: Int?
    var strength: Int
    var belongsToClub: Bool
    var games: Int = 0
    var wins: Int = 0
    var ties: Int = 0
    var losses: Int = 0
    var winPercentage: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case number = "number"
        case strength = "strength"
        case belongsToClub = "belongsToClub"
        case games = "games"
        case wins = "wins"
        case ties = "ties"
        case losses = "losses"
    }
    
    init(uid: Int,
         name: String,
         number: Int?,
         strength: Int,
         belongsToClub: Bool) {
        self.uid = uid
        self.name = name
        self.number = number
        self.strength = strength
        self.belongsToClub = belongsToClub
        
        if games > 0 {
            winPercentage = Int((Float(wins) / Float(games)) * 100.0)
        }
    }
    
    init(uid: Int,
         name: String,
         number: Int?,
         strength: Int,
         belongsToClub: Bool,
         games: Int,
         wins: Int,
         ties: Int,
         losses: Int) {
        self.uid = uid
        self.name = name
        self.number = number
        self.strength = strength
        self.belongsToClub = belongsToClub
        self.games = games
        self.wins = wins
        self.ties = ties
        self.losses = losses
        
        if games > 0 {
            winPercentage = Int((Float(wins) / Float(games)) * 100.0)
        }
    }
}

// MARK: Convenience initializers and mutators
extension Player {
    init(data: Data) throws {
        self = try JSONDecoder.JSONDecoderISODate().decode(Player.self, from: data)
        
        if games > 0 {
            winPercentage = Int((Float(wins) / Float(games)) * 100.0)
        }
    }
    
    init(dictionary: [String: Any]) throws {
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        self = try JSONDecoder.JSONDecoderISODate().decode(Player.self, from: jsonData!)
        
        if games > 0 {
            winPercentage = Int((Float(wins) / Float(games)) * 100.0)
        }
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder.JSONEncoderISODate().encode(self)
    }
    
    func jsonDictionary() throws -> [String: Any] {
        return try JSONSerialization.jsonObject(with: jsonData(), options: []) as! [String: Any]
    }
}

// MARK: Convenience initializers and mutators
extension Player: Equatable {
    static func ==(rhs: Player, lhs: Player) -> Bool {
        return rhs.uid == lhs.uid
    }
}
