import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = CompassViewModel()

    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Step Compass")
                .font(.largeTitle)
                .padding()

            VStack(alignment: .leading, spacing: 12) {
                Text("Steps: \(viewModel.stepCount)")
                    .font(.title2)

                Text("Heading: \(Int(viewModel.heading))° \(Constants.CardinalDirections.degreeToDirection(viewModel.heading))")
                    .font(.title2)

                Text("Position: \(viewModel.position.formattedString())")
                    .font(.title2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Constants.UI.Colors.secondaryBackground)
            .cornerRadius(Constants.UI.cornerRadius)
            .padding(.horizontal)

            CompassView(heading: viewModel.heading)
                .padding()

            Button("Reset Position") {
                viewModel.resetPosition()
            }
            .padding()
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.startTracking()
        }
        .onDisappear {
            viewModel.stopTracking()
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
