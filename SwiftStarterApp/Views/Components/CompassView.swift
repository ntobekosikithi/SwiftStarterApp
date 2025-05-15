import SwiftUI

struct CompassView: View {
    var heading: Double

    let directions = stride(from: 0.0, to: 360.0, by: 45.0).map { $0 }

    @State private var animatedHeading: Double = 0.0

    var body: some View {
        ZStack {

            ForEach(directions, id: \.self) { angle in
                let direction = Constants.CardinalDirections.degreeToDirection(angle)
                VStack {
                    Text(direction)
                        .font(angle.truncatingRemainder(dividingBy: 90) == 0 ? .headline.bold() : .caption)
                        .foregroundColor(angle.truncatingRemainder(dividingBy: 90) == 0 ? .black : .gray)
                    Spacer()
                }
                .rotationEffect(.degrees(angle - animatedHeading))
            }

            Rectangle()
                .fill(Constants.UI.Colors.accent)
                .frame(width: 4, height: 100)
                .offset(y: -50)
        }
        .frame(width: 240, height: 240)
        .onChange(of: heading) { newHeading in
            withAnimation(Constants.UI.Animation.compass) {
                animatedHeading = adjustedHeading(from: animatedHeading, to: newHeading)
            }
        }
        .onAppear {
            animatedHeading = heading.truncatingRemainder(dividingBy: 360)
        }
    }

    /// Adjusts heading to take the shortest animation path
    private func adjustedHeading(from current: Double, to new: Double) -> Double {
        let delta = new - current
        if abs(delta) > 180 {
            return delta > 0 ? current + (delta - 360) : current + (delta + 360)
        }
        return new
    }
}


// MARK: - Preview

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView(heading: 45)
            .previewLayout(.sizeThatFits)
            .padding()
    }
} 
