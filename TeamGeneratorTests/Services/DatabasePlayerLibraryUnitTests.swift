//
//  DatabasePlayerLibraryUnitTests.swift
//  TeamGeneratorTests
//
//  Created by CTW00169 on 13/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import XCTest
@testable import TeamGenerator

class DatabasePlayerLibraryUnitTests: XCTestCase {
    let players = [Players.playerOne, Players.playerTwo]
    let playerToAdd = Players.playerThree
    let playerToRemove = Players.playerTwo
    
    var sut: DatabasePlayerLibrary!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.        
        sut = DatabasePlayerLibrary(database: "playersTest")
        sut.databaseReference.setValue(nil)
        
        do {
            for player in players {
                let data = try player.jsonDictionary()
                sut.databaseReference.child(String(player.uid)).setValue(data)
            }
        } catch {
            
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testFetchPlayers() {
        // Arrange

        // Act
        var playersFetched: [Player]?
        let playersExpectation = expectation(description: "Wait for players to be fetched")
        sut.fetch { (players) in
            playersFetched = players
            playersExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playersFetched, "Players should be fetch successfully")
        XCTAssertEqual(playersFetched, players, "Players should be fetch successfully")
    }
    
    func testAddPlayer() {
        // Arrange
        
        // Act
        var playerAdded: Player?
        let playerExpectation = expectation(description: "Wait for players to be added")
        sut.add(playerToAdd) { (player) in
            playerAdded = player
            playerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playerAdded, "Player should be added successfully")
        XCTAssertEqual(playerAdded, playerToAdd, "Player should be added successfully")
    }
    
    func testRemovePlayer() {
        // Arrange
        sut.players = players
        
        // Act
        var playerRemoved: Player?
        let playerExpectation = expectation(description: "Wait for players to be removed")
        sut.remove(1) { (player) in
            playerRemoved = player
            playerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playerRemoved, "Player should be removed successfully")
        XCTAssertEqual(playerRemoved, players[1], "Player should be removed successfully")
    }
    
    func testUpdatePlayer() {
        // Arrange
        sut.players = players
        var playerToUpdate = players[1]
        playerToUpdate.number = 21
        playerToUpdate.name = "Twenty One"
        
        // Act
        var playerUpdated: Player?
        let playerExpectation = expectation(description: "Wait for players to be updated")
        sut.update(playerToUpdate) { (player) in
            playerUpdated = player
            playerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        // Assert
        XCTAssertNotNil(playerUpdated, "Player should be updated successfully")
        XCTAssertEqual(playerUpdated, playerToUpdate, "Player should be updated successfully")
    }    
}
