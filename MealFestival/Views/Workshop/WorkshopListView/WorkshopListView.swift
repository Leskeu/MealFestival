
import SwiftUI

struct WorkshopListView: View {
    @Environment(UserStore.self) private var userStore

    @State private var workshopVM = WorkshopViewModel()
    
    @State private var showReservation: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.charcoal
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Text(!showReservation ? "Workshops" : "My Reservations")
                    .font(.custom("Montserrat-ExtraBold", size: 40))
                    .foregroundStyle(.white)

                ScrollView {
                    ForEach(workshopVM.workshops) { wk in
                        WorkshopCardView(workshop: wk)
                    }
                }
            }
            .padding()
            .padding(.top, 45)
            
            HStack(alignment: .center, spacing: 10) {
                if showReservation {
                    ReservationsButton(title: "Workshops", style: .red) {
                        Task {
                            await workshopVM.getWorkshops()
                            showReservation.toggle()
                        }
                    }
                } else {
                    ReservationsButton(title: "My Reservations", style: .green) {
                        Task {
                            if let token = userStore.token {
                                await workshopVM.getReservedWorkshops(token: token)
                                showReservation.toggle()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 13)
            .frame(width: 402, alignment: .center)
            .background(
              LinearGradient(
                stops: [
                  Gradient.Stop(color: .black.opacity(0), location: 0.00),
                  Gradient.Stop(color: .black, location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.47, y: 0),
                endPoint: UnitPoint(x: 0.47, y: 1)
              )
            )
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    userStore.deleteToken()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
                .tint(.white)
            }
        }
        .task {
            await workshopVM.getWorkshops()
        }
    }
}

#Preview {
    NavigationStack {
        WorkshopListView()
    }
    .environment(UserStore())
}
