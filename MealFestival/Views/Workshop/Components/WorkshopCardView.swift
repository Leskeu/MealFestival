//
//  WorkshopCardView.swift
//  MealFestival
//
//  Created by Filip Rizov on 06/10/2026.
//

import SwiftUI

@Observable
class WorkshopCardViewModel {
    @ObservationIgnored
    private let reservationsRepository = ReservationRepository()

    var isLoading = false
    var errorMessage: String?

    func participate(workshopID: UUID, token: String?) async -> Bool {
        guard let token else {
            errorMessage = "Please log in to participate."
            return false
        }

        isLoading = true
        errorMessage = nil

        let createReservationDTO = CreateReservationDTO(workshopID: workshopID)

        let success = await reservationsRepository.askToParticipate(
            createReservationDTO: createReservationDTO,
            token: token
        )

        if !success {
            errorMessage = "Participation failed. Please try again."
        }

        isLoading = false
        return success
    }

    func cancel(reservationID: UUID, token: String?) async -> Bool {

        guard let token else {
            errorMessage = "Please log in to cancel."
            return false
        }


        isLoading = true
        errorMessage = nil

        do {
            try await reservationsRepository.askToCancel(
                reservationID: reservationID,
                token: token
            )
            isLoading = false
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
}

struct WorkshopCardView: View {
    @Environment(UserStore.self) private var userStore

    let workshop: Workshop
    let reservationStatus: String?
    let reservationId: UUID?
    let showReservation: Bool
    let onParticipate: () async -> Void
    let onCancel: () async -> Void

    @State private var cardVM = WorkshopCardViewModel()
    @State private var expanded = false

    var isReserved: Bool {
        reservationStatus == "validée"
    }

    var buttonTitle: String {
        if cardVM.isLoading { return "Loading..." }
        if showReservation { return "Cancel" }
        if isReserved { return "Reserved" }
        if workshop.availableSpot == 0 { return "Full" }
        return "Participate"
    }

    var buttonColor: Color {
        if showReservation { return .brick }
        if isReserved { return .jungle }
        return .charcoal
    }

    var isButtonDisabled: Bool {
        if showReservation { return cardVM.isLoading || reservationId == nil }

        return isReserved
            || cardVM.isLoading
            || workshop.availableSpot == 0
    }

    func formatDate(_ isoDate: String, format: String) -> String {
        let isoFormatter = ISO8601DateFormatter()

        guard let date = isoFormatter.date(from: isoDate) else {
            return isoDate
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.timeZone = TimeZone(identifier: "Europe/Paris")
        formatter.dateFormat = format

        return formatter.string(from: date)
    }

    func handleButtonAction() {
        guard !isButtonDisabled else { return }


        if showReservation {
            guard let reservationId else { return }
            Task {
                if await cardVM.cancel(
                    reservationID: reservationId,
                    token: userStore.token
                ) {
                    await onCancel()
                }
            }
            return
        }

        Task {
            if await cardVM.participate(
                workshopID: workshop.id,
                token: userStore.token
            ) {
                await onParticipate()
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(workshop.name)
                .foregroundStyle(.black)
                .font(.montserrat(.extrabold, size: 20))
                .padding(.horizontal, 8)
                .padding(.top, 8)

            if expanded {
                Text(workshop.categoryName)
                    .padding(.horizontal, 8)
            }

            HStack {
                Text(formatDate(workshop.startTime, format: "HH'h'"))
                Text("-")
                Text(formatDate(workshop.endTime, format: "HH'h'"))

                Spacer()

                Text(formatDate(workshop.startTime, format: "d MMM"))
            }
            .font(.montserrat(.semibold, size: 18))
            .padding(.horizontal, 8)

            Group {
                if !expanded {
                    HStack(spacing: 0) {
                        Text("\(workshop.availableSpot)")
                            .fontWeight(.semibold)
                        Text(" spots left")
                    }
                    .font(.montserrat(.regular, size: 18))
                } else {
                    HStack(spacing: 0) {
                        Text("\(workshop.totalSubscribers) / \(workshop.maxCapacity)")
                            .fontWeight(.semibold)
                        Text(" spots available")
                    }
                    .font(.montserrat(.regular, size: 18))
                }
            }
            .padding(.horizontal, 8)

            if expanded {
                Text(workshop.description)
                    .padding(.horizontal, 8)

                if let reservationStatus {
                    Text("Reservation: \(reservationStatus)")
                        .padding(.horizontal, 8)
                }
            }

            if let errorMessage = cardVM.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 8)
            }

            HStack {
                Button {
                    expanded.toggle()
                } label: {
                    Image("chevron")
                        .resizable()
                        .rotationEffect(
                            .degrees(expanded ? 0 : 180)
                        )
                        .frame(width: 30, height: 25)
                        .padding(.trailing, 10)
                }

                Spacer()

                if !expanded {
                    Button(action: handleButtonAction) {
                        Text(buttonTitle)
                            .foregroundStyle(.white)
                            .font(.montserrat(.semibold, size: 18))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 8)
                            .kerning(1.8)
                            .background(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: 20,
                                    bottomLeadingRadius: 4,
                                    bottomTrailingRadius: 20,
                                    topTrailingRadius: 4,
                                    style: .continuous
                                )
                                .fill(buttonColor)
                            )
                    }
                    .disabled(isButtonDisabled)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, expanded ? 0 : 8)

            if expanded {
                Button(action: handleButtonAction) {
                    Text(buttonTitle)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .font(.montserrat(.semibold, size: 18))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .kerning(1.8)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 14,
                                bottomTrailingRadius: 14,
                                topTrailingRadius: 0,
                                style: .continuous
                            )
                            .fill(buttonColor)
                        )
                        .padding(2)
                }
                .disabled(isButtonDisabled)
            }
        }
        .font(.montserrat(.regular, size: 18))
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.white)
        )
    }
}

#Preview {
    let workshop = Workshop(
        id: UUID(),
        name: "Homemade Burger",
        categoryName: "Street Food",
        startTime: "2026-11-03T14:35:04Z",
        endTime: "2026-11-03T18:35:04Z",
        maxCapacity: 21,
        totalSubscribers: 15,
        availableSpot: 6,
        description: "Discover our homemade burger workshop: Make your own burger from A to Z with fresh products, delicious sauces and salads."
    )

    ZStack {
        Color.charcoal.ignoresSafeArea()

        WorkshopCardView(
            workshop: workshop,
            reservationStatus: "validée",
            reservationId: UUID(),
            showReservation: true,
            onParticipate: {},
            onCancel: {}
        )
        .padding()
        .environment(UserStore())
    }
}
