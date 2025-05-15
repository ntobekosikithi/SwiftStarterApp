import Foundation
import Combine

class CompassViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var stepCount: Int = UserDefaultsManager.shared.loadStepCount()
    @Published var heading: Double = 0
    @Published var position: Position = UserDefaultsManager.shared.loadPosition()

    // MARK: - Private Properties
    private let motionService: MotionServiceProtocol
    private let positionCalculator: PositionCalculatorProtocol
    private var stepTask: Task<Void, Never>?
    private var headingTask: Task<Void, Never>?
    private var lastRecordedStepCount: Int = 0

    // MARK: - Initialization
    init(motionService: MotionServiceProtocol = MotionService(),
         positionCalculator: PositionCalculatorProtocol = PositionCalculator()) {
        self.motionService = motionService
        self.positionCalculator = positionCalculator
    }

    // MARK: - Public Methods
    func startTracking() {
        motionService.start()

        stepTask = Task {
            for await count in motionService.stepStream {
                await MainActor.run {
                    self.stepCount = count
                    UserDefaultsManager.shared.saveStepCount(count)

                    let stepsSinceLastUpdate = count - self.lastRecordedStepCount
                    if stepsSinceLastUpdate >= Constants.Motion.positionUpdateStepInterval {
                        self.position = self.positionCalculator.calculateNewPosition(
                            currentPosition: self.position,
                            steps: stepsSinceLastUpdate,
                            heading: self.heading
                        )
                        UserDefaultsManager.shared.savePosition(self.position)
                        self.lastRecordedStepCount = count
                    }
                }
            }
        }

        headingTask = Task {
            for await newHeading in motionService.headingStream {
                await MainActor.run {
                    self.heading = newHeading
                }
            }
        }
    }

    func stopTracking() {
        stepTask?.cancel()
        headingTask?.cancel()
        motionService.stop()
    }

    func resetPosition() {
        position = .origin
        stepCount = 0
        lastRecordedStepCount = 0
        UserDefaultsManager.shared.clearAll()
    }
}
