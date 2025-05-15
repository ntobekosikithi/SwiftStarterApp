import Foundation
import CoreMotion
import CoreLocation

// This is a template for the MotionService
// Candidates should implement this service to handle motion data
// as per the assignment requirements

protocol MotionServiceProtocol {
    var stepStream: AsyncStream<Int> { get }
    var headingStream: AsyncStream<CLLocationDirection> { get }
    func start()
    func stop()
}

// Example implementation outline
class MotionService: NSObject, MotionServiceProtocol, CLLocationManagerDelegate {
    
    // MARK: - Properties
    private let pedometer = CMPedometer()
    private let locationManager = CLLocationManager()
    private var stepContinuation: AsyncStream<Int>.Continuation?
    private var headingContinuation: AsyncStream<CLLocationDirection>.Continuation?
    private var steps = 0
    
    var stepStream: AsyncStream<Int> {
        AsyncStream { continuation in
            self.stepContinuation = continuation
        }
    }

    var headingStream: AsyncStream<CLLocationDirection> {
        AsyncStream { continuation in
            self.headingContinuation = continuation
        }
    }
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupLocationManager()
    }
    
    // MARK: - Public Methods
    func start() {
        locationManager.startUpdatingHeading()

        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] data, error in
                guard let self, let data = data else { return }
                self.steps = data.numberOfSteps.intValue
                self.stepContinuation?.yield(self.steps)
            }
        }
    }

    func stop() {
        pedometer.stopUpdates()
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - Private Methods
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.headingOrientation = .portrait
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        headingContinuation?.yield(heading)
    }

}

// Example of how to create a mock for testing
class MockMotionService: MotionServiceProtocol {
    var stepStream: AsyncStream<Int> {
        AsyncStream { continuation in
            DispatchQueue.global().async {
                for i in stride(from: 0, to: 100, by: 1) {
                    continuation.yield(i)
                    Thread.sleep(forTimeInterval: 0.5)
                }
            }
        }
    }

    var headingStream: AsyncStream<CLLocationDirection> {
        AsyncStream { continuation in
            DispatchQueue.global().async {
                let headings = [0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0]
                var index = 0
                while true {
                    continuation.yield(headings[index % headings.count])
                    index += 1
                    Thread.sleep(forTimeInterval: 1.0)
                }
            }
        }
    }

    func start() {}
    func stop() {}
}

