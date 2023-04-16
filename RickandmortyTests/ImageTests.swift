//
//  DeleteTests.swift
//  rickandmortyTests
//
//  Created by Belén Cerezo on 16/4/23.
//

import Foundation
import XCTest
@testable import rickandmorty

class ImageTests: XCTestCase {
    
    var characterTest: Character?
    
    override func setUp() {
        characterTest = Character(id: 1, name: "Sonia", status: "", species: "", type: "", gender: "", image: "")
    }
    
    override func tearDown() {
        characterTest = nil
    }
    
    func testImage() {
        // Given
        let expectedResult = "https://rickandmortyapi.com/api/character/avatar/66.jpeg"
        
        // When
        let currentResult = characterTest?.imageURL
        
        // Then
        XCTAssertEqual(expectedResult, currentResult)
        
    }
}
