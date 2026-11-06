
import SwiftUI

struct WorkshopListView: View {
    @Environment(UserStore.self) private var userStore

    @State private var workshopVM = WorkshopViewModel()
    
    @State private var showReservation: Bool = false

    var displayedWorkshops: [WorkshopWithReservation] {
        if showReservation {
            return workshopVM.workshops.filter {
                $0.reservationDTO?.status == "validée"
            }
        }

        return workshopVM.workshops
    }
    
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
                
                if !displayedWorkshops.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        ScrollView {
                            ForEach(displayedWorkshops) { item in
                                WorkshopCardView(
                                    workshop: item.workshopDTO,
                                    reservationStatus: item.reservationDTO?.status,
                                    reservationId: item.reservationDTO?.id,
                                    showReservation: showReservation,
                                    onParticipate: {
                                        if let token = userStore.token {
                                            await workshopVM.getWorkshops(token: token)
                                            showReservation = true
                                        }
                                    },
                                    onCancel: {
                                        if let token = userStore.token {
                                            await workshopVM.getWorkshops(token: token)
                                        }
                                    }
                                )
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
                                if let token = userStore.token {
                                    await workshopVM.getWorkshops(token: token)
                                }
                                showReservation = false
                            }
                        }
                    } else {
                        ReservationsButton(title: "My Reservations", style: .green) {
                            Task {
                                if let token = userStore.token {
                                    await workshopVM.getWorkshops(token: token)
                                }
                                showReservation = true
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
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    userStore.deleteToken()
//                } label: {
//                    Image(systemName: "rectangle.portrait.and.arrow.right")
//                }
//                .tint(.white)
//            }
//        }
        .task {
            if let token = userStore.token {
                await workshopVM.getWorkshops(token: token)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WorkshopListView()
    }
    .environment(UserStore())
}
