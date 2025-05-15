## **Waymap iOS Developer: Take-Home Assignment**

---

### **Context**

Waymap’s iOS app guides users with visual impairments by fusing real-time sensor data and trigonometric algorithms into a clear, responsive interface. In this assignment, you'll implement a simplified version of a “Step Compass” feature. This task will test your ability to work with live sensor streams, apply mathematical logic for positional tracking, and build a polished, responsive SwiftUI interface.

### **Timeframe**

The assignment should take around 2-3 hours to complete. Use this as a guideline for how much effort to put into completeness and optimizations. Read through the entire assignment before you begin to get an idea of the scope and how you would like to structure your work.

### **Setup**

Download this starter repository. You are welcome to create your own project from scratch instead of using the starter repo.

### **Requirements**

#### **1\. Sensor data and concurrency**

* Use `CMPedometer` to continuously track and stream the user’s step count in real-time.  
* Use either `CMMotionManager` or `CLLocationManager` to stream the device’s heading (0–360°).  
* Wrap each data stream in either a Swift **actor** or **async sequence**, ensuring that all UI updates occur on the **main actor**. This approach should maintain smooth and responsive UI updates without blocking the main thread.

#### **2\. Position calculation**

* Assume each step is **0.75 meters** in length.  
* Starting at Cartesian coordinates **(0.0, 0.0)**, calculate a new position every 10 steps using the current heading. Apply the following formulas:

```
x += stepLength * cos(headingRadians)
y += stepLength * sin(headingRadians)
```

* Encapsulate this logic in a dedicated `PositionCalculator` type.  
* Write **unit tests** for this type, covering at least three different heading angles (e.g., 0°, 90°, 225°) to demonstrate correct directional movement and distance tracking.

#### **3\. SwiftUI Interface**

* Create a SwiftUI interface that displays:  
  * **Step Count**, such as “Steps: 123”  
  * **Heading**, such as “Heading: 270° W”  
  * **Current Position**, such as “Position: (12.3 m, –4.5 m)”  
* Include a **visual compass element**, such as a rotating needle or ring, that reflects heading changes in real time. The rotation should animate smoothly with each change in heading direction.

#### **4\. Architecture**

* Separate responsibilities clearly across files:  
  * `MotionService.swift` for managing and streaming sensor data  
  * `PositionCalculator.swift` for handling position math and test logic  
  * `ContentView.swift` for building the UI interface  
* Use **dependency injection** so that real services can be swapped out for mocks in testing or previews.

### **Deliverables**

* **README.md** including:  
  * A brief overview of your approach  
  * Build and run instructions  
  * Key assumptions or trade-offs made  
  * Ideas for next steps if given more time  
* **GitHub repository or zip file**, including:  
  * `StepCompassApp.swift`  
  * `MotionService.swift`  
  * `PositionCalculator.swift`  
  * `ContentView.swift`  
  * Any additional helper files or mocks used  
  * **Unit tests**: At least one test suite validating `PositionCalculator`.  
* **Video demo** (5–10 min):  
  * Show the app working on a device or simulator  
  * Explain your approach to architecture, sensor handling, and concurrency  
  * Reflect briefly on challenges, design decisions, and potential improvements

