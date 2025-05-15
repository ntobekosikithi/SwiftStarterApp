import Foundation
import SwiftUI

/// App-wide constants
enum Constants {
    /// Step and motion-related constants
    enum Motion {
        static let defaultStepLength: Double = 0.75 // meters
        static let positionUpdateStepInterval: Int = 10 // update position every 10 steps
        static let motionUpdateInterval: TimeInterval = 0.1 // seconds
    }
    
    /// UserDefaults keys
    enum UserDefaultsKeys {
        static let lastPosition = "lastPosition"
        static let totalStepCount = "totalStepCount"
    }
    
    /// UI-related constants
    enum UI {
        static let cornerRadius: CGFloat = 8.0
        static let standardPadding: CGFloat = 16.0
        static let smallPadding: CGFloat = 8.0
        static let largePadding: CGFloat = 24.0
        
        /// App colors
        enum Colors {
            static let primary = Color.blue
            static let secondary = Color.gray
            static let accent = Color.red // For compass needle
            static let background = Color(.systemBackground)
            static let secondaryBackground = Color(.secondarySystemBackground)
        }
        
        /// Animation constants
        enum Animation {
            static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
            static let compass = SwiftUI.Animation.easeOut(duration: 0.2) // For smooth compass rotation
        }
    }
    
    /// Cardinal directions
    enum CardinalDirections {
        static let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]

        static func degreeToDirection(_ degree: Double) -> String {
            let normalizedDegree = (degree.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
            let index = Int((normalizedDegree + 22.5) / 45.0) % 8
            return directions[index]
        }
    }

}

// Usage examples:
// let padding = Constants.UI.standardPadding
// let color = Constants.UI.Colors.primary
// let itemsKey = Constants.UserDefaultsKeys.savedItems 
