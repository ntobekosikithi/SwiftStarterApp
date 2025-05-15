import Foundation

// This is a template for the PositionCalculator
// Candidates should implement this utility to calculate position based on steps and heading
// as per the assignment requirements

protocol PositionCalculatorProtocol {
    func calculateNewPosition(currentPosition: Position, steps: Int, heading: Double) -> Position
}

class PositionCalculator: PositionCalculatorProtocol {
    // MARK: - Properties
    
    let stepLength: Double = Constants.Motion.defaultStepLength

    // MARK: - Public Methods
    
    /// Calculates a new position based on the current position, steps taken, and heading direction
    /// - Parameters:
    ///   - currentPosition: The current (x,y) position
    ///   - steps: Number of steps taken
    ///   - heading: The heading in degrees (0-360)
    /// - Returns: The new position
    func calculateNewPosition(currentPosition: Position, steps: Int, heading: Double) -> Position {
        let headingRadians = degreesToRadians(heading)
        let distance = Double(steps) * stepLength
        let deltaX = distance * cos(headingRadians)
        let deltaY = distance * sin(headingRadians)
        return Position(x: currentPosition.x + deltaX, y: currentPosition.y + deltaY)
    }
    
    // MARK: - Private Methods
    
    /// Converts degrees to radians
    /// - Parameter degrees: The angle in degrees
    /// - Returns: The angle in radians
    private func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180.0
    }
} 
