import Foundation

/// Represents a 2D position in Cartesian coordinates (meters)
struct Position: Codable, Equatable {
    var x: Double
    var y: Double
    
    /// The origin position (0,0)
    static let origin = Position(x: 0.0, y: 0.0)
    
    /// Calculate the distance from origin
    var distanceFromOrigin: Double {
        return sqrt(x*x + y*y)
    }
    
    /// Returns a formatted string representation of the position
    /// - Returns: A string in the format "(x.x m, y.y m)"
    func formattedString() -> String {
        return String(format: "(%.1f m, %.1f m)", x, y)
    }
} 