import XCTest
@testable import SwiftStarterApp

final class PositionCalculatorTests: XCTestCase {
    // MARK: - Properties

    var positionCalculator: PositionCalculator!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        positionCalculator = PositionCalculator()
    }

    override func tearDown() {
        positionCalculator = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    // Test heading East (0 degrees)
    func testCalculatePositionHeadingEast() {
        // Given - Starting position and heading east (0 degrees)
        let startPosition = Position.origin
        let heading = 0.0
        let steps = 10
        
        // When - Calculate new position
        let newPosition = positionCalculator.calculateNewPosition(
            currentPosition: startPosition,
            steps: steps,
            heading: heading
        )
        
        // Then - Should move along positive X axis
        XCTAssertEqual(newPosition.x, 7.5, accuracy: 0.001) // 10 steps * 0.75m
        XCTAssertEqual(newPosition.y, 0.0, accuracy: 0.001)
    }
    
    // Test heading North (90 degrees)
    func testCalculatePositionHeadingNorth() {
        // Given - Starting position and heading north (90 degrees)
        let startPosition = Position.origin
        let heading = 90.0
        let steps = 10
        
        // When - Calculate new position
        let newPosition = positionCalculator.calculateNewPosition(
            currentPosition: startPosition,
            steps: steps,
            heading: heading
        )
        
        // Then - Should move along positive Y axis
        XCTAssertEqual(newPosition.x, 0.0, accuracy: 0.001)
        XCTAssertEqual(newPosition.y, 7.5, accuracy: 0.001) // 10 steps * 0.75m
    }
    
    // Test heading Southwest (225 degrees)
    func testCalculatePositionHeadingSouthwest() {
        // Given - Starting position and heading southwest (225 degrees)
        let startPosition = Position.origin
        let heading = 225.0
        let steps = 10
        
        // When - Calculate new position
        let newPosition = positionCalculator.calculateNewPosition(
            currentPosition: startPosition,
            steps: steps,
            heading: heading
        )
        
        // Then - Should move in negative X and negative Y
        XCTAssertEqual(newPosition.x, -5.303, accuracy: 0.001) // 10 steps * 0.75m * cos(225°)
        XCTAssertEqual(newPosition.y, -5.303, accuracy: 0.001) // 10 steps * 0.75m * sin(225°)
    }
    
    // Test multiple position calculations from a non-origin starting point
    func testMultiplePositionCalculations() {
        // Start at a non-origin position
        let startPosition = Position(x: 10.0, y: 5.0)
        
        // First move East for 10 steps
        let midPosition = positionCalculator.calculateNewPosition(
            currentPosition: startPosition,
            steps: 10,
            heading: 0.0
        )
        
        // Verify mid position
        XCTAssertEqual(midPosition.x, 17.5, accuracy: 0.001) // 10 + 10*0.75
        XCTAssertEqual(midPosition.y, 5.0, accuracy: 0.001)
        
        // Then move North for 5 steps
        let finalPosition = positionCalculator.calculateNewPosition(
            currentPosition: midPosition,
            steps: 5,
            heading: 90.0
        )
        
        // Verify final position
        XCTAssertEqual(finalPosition.x, 17.5, accuracy: 0.001)
        XCTAssertEqual(finalPosition.y, 8.75, accuracy: 0.001) // 5 + 5*0.75
    }
    
    // Test edge cases
    func testEdgeCases() {
        // Test with 0 steps (should not change position)
        let position = Position(x: 5.0, y: 5.0)
        let newPosition = positionCalculator.calculateNewPosition(
            currentPosition: position,
            steps: 0,
            heading: 45.0
        )
        XCTAssertEqual(position.x, newPosition.x)
        XCTAssertEqual(position.y, newPosition.y)
        
        // Test with very large heading (should normalize correctly)
        let largeHeadingPosition = positionCalculator.calculateNewPosition(
            currentPosition: Position.origin,
            steps: 10,
            heading: 450.0 // Same as 90° after normalization
        )
        XCTAssertEqual(largeHeadingPosition.x, 0.0, accuracy: 0.001)
        XCTAssertEqual(largeHeadingPosition.y, 7.5, accuracy: 0.001)
    }
}
