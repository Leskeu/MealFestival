
import SwiftUI

enum ReservationsButtonStyle {
    case green
    case red

    var gradient: [Color] {
        switch self {
        case .green:
            return [
                Color(red: 0.16, green: 0.79, blue: 0.57),
                Color(red: 0.08, green: 0.68, blue: 0.49)
            ]
        case .red:
            return [
                Color(red: 0.77, green: 0.31, blue: 0.27),
                Color(red: 0.88, green: 0.39, blue: 0.35)
            ]
        }
    }
}

struct ReservationsButton: View {
    let title: String
    let style: ReservationsButtonStyle
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .frame(minWidth: 176, minHeight: 49)
                .background {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: style.gradient,
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .overlay {
                            Capsule()
                                .strokeBorder(
                                    .white.opacity(0.2),
                                    lineWidth: 1
                                )
                        }
                }
                .shadow(
                    color: .black.opacity(0.2),
                    radius: 8,
                    y: 4
                )
        }
        .buttonStyle(.plain)
    }
}
