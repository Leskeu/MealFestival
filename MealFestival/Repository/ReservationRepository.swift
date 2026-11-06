//
//  ReservationRepository.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

@MainActor
@Observable
final class ReservationRepository {

    let webService = WebService()
    let baseUrl = "reservations"

    //participate
    func askToParticipate(createReservationDTO: CreateReservationDTO, token: String) async throws {
        try await webService.apiCallStatus(
            url: self.baseUrl + "/participate",
            method: "POST",
            body: createReservationDTO,
            token: token
        )
    }

    //cancel
    func askToCancel(reservationID: UUID, token: String) async throws {
        try await webService.apiCallStatus(
            url: self.baseUrl + "/cancel/" + reservationID.uuidString,
            method: "DELETE",
            token: token
        )
    }


}
