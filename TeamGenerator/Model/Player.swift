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
    var strength: Int
    var belongsToClub: Bool
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case strength = "strength"
        case belongsToClub = "belongsToClub"
    }
}

// MARK: Convenience initializers and mutators
extension Player {
    init(data: Data) throws {
        self = try JSONDecoder.JSONDecoderISODate().decode(Player.self, from: data)
    }
    
    init(dictionary: [String: Any]) throws {
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        self = try JSONDecoder.JSONDecoderISODate().decode(Player.self, from: jsonData!)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        uid: Int? = nil,
        name: String? = nil,
        strength: Int? = nil,
        belongsToClub: Bool? = nil
        ) -> Player {
        return Player(
            uid: uid ?? self.uid,
            name: name ?? self.name,
            strength: strength ?? self.strength,
            belongsToClub: belongsToClub ?? self.belongsToClub
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder.JSONEncoderISODate().encode(self)
    }
    
    func jsonDictionary() throws -> [String: Any] {
        return try JSONSerialization.jsonObject(with: jsonData(), options: []) as! [String: Any]
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
