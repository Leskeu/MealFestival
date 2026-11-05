
import SwiftUI

struct WorkshopListView: View {
    @Environment(UserStore.self) private var userStore

    @State private var workshopVM = WorkshopViewModel()
    
    @State private var showReservation: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.charcoal
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Text(!showReservation ? "Workshops" : "My Reservations")
                    .font(.custom("Montserrat-ExtraBold", size: 34))
                    .foregroundStyle(.white)
                    .padding(.top, 60)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if (workshopVM.workshops != []) {
                    VStack(alignment: .leading, spacing: 16) {
                        ScrollView {
                            ForEach(workshopVM.workshops) { wk in
                                WorkshopCardView(workshop: wk)
                                    .environment(userStore)
                            }
                        }
                    }
                    .contentMargins(16, for: .scrollContent)
                } else {
                    Spacer()
                    Text("No workshops for now, please try again later.")
                        .foregroundStyle(.white)
                        .font(.montserrat(.semibold, size: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
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
                                await workshopVM.getReservedWorkshops()
                                showReservation.toggle()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
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
