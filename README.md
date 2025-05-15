# Swift iOS Step Compass Assignment

Step Compass is a SwiftUI-based iOS application that tracks a user's heading and steps using Core Motion. It calculates and updates the user's position based on their heading every 10 steps, and visually represents the direction using a dynamic compass. The app is designed to demonstrate integration of motion sensors, real-time UI updates, and modular architecture following Swift best practices.

## Assignment Overview

Build a "Step Compass" feature that:
- Tracks step counts using CMPedometer
- Monitors device heading using CMMotionManager or CLLocationManager
- Calculates position based on steps and heading
- Displays information in a polished SwiftUI interface

## Requirements

- Xcode 15.0+
- iOS 17.0+
- Swift 5.10+

 ### Steps:
      * Clone the repository.
      * Open StepCompass.xcodeproj in Xcode.
      * Select a real iOS device as the target (motion data is not available on simulators).
      * Run the app using Cmd + R.

## Project Structure

```
SwiftStarterApp/
├── App/
│   └── StepCompassApp.swift      # App entry point
├── Models/
│   └── Position.swift            # Basic position model
├── Views/
│   ├── ContentView.swift         # Template for main content view
│   └── Components/                
│       └── CompassView.swift     # Basic compass component template
├── ViewModels/
│   └── CompassViewModel.swift    # View model template
├── Services/
│   └── MotionService.swift       # Template for motion services
├── Utilities/
│   ├── Constants.swift           # App constants
│   └── PositionCalculator.swift  # Template for position calculations
└── Resources/
    ├── Assets.xcassets           # Images and colors
    └── Preview Content/          # Preview assets
```


### 1. Motion Service

Implement `MotionService.swift` to:
- Stream step counts using CMPedometer
- Stream heading data using CMMotionManager or CLLocationManager
- Use Swift concurrency (actors or async streams)

### 2. Position Calculator

Implement `PositionCalculator.swift` to:
- Calculate new positions based on steps and heading
- Use the provided formula: `x += stepLength * cos(headingRadians)` and `y += stepLength * sin(headingRadians)`
- Ensure calculations are testable

### 3. UI Components

Implement:
- Connect and enhance `ContentView.swift` to display real-time data
- Improve the basic `CompassView.swift` to create a proper compass visualization
- Add appropriate animations for smooth heading changes

### 4. ViewModel

Implement the CompassViewModel:
- Add appropriate @Published properties
- Implement position tracking and updating
- Connect motion services to update the view

### 5. Tests

Write tests in `PositionCalculatorTests.swift` to verify:
- Position calculation accuracy for different headings
- Edge cases and error handling

## Key Assumptions & Trade-offs
   * Accuracy vs. Simplicity: Position is estimated with simple trigonometry assuming flat movement on a 2D plane. No use of GPS or real-world location services for simplicity and focus on sensor-based direction.
   * Step Interval: Position updates are made every 10 steps to reduce over-processing and noise. This number is configurable.
   * Smooth Heading Animation: A custom heading delta calculation ensures smooth transitions between angles, especially around the 360° → 0° seam.
   * MotionService Mockability: MotionServiceProtocol enables testability and future mocking, but no unit tests are included due to time constraints.

## Next Steps / Ideas for Improvement
   * 🔍 Refine Compass Precision: Use magnetometer calibration to improve directional accuracy, and possibly show deviation degrees.
   * 🗺️ Add Map Integration: Visualize movement on a map or grid-based UI for real-world tracking.
   * 🧪 Unit Testing: Add tests for CompassViewModel, PositionCalculator, and edge cases around heading changes.
   * ⚙️ Settings Screen: Allow user to configure step threshold or toggle live heading updates.
   * 🧭 Better Compass Visuals: Add intermediate ticks, smoother gradients, or 3D-style UI for a more realistic compass.