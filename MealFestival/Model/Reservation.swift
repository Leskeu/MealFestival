//
//  Reservation.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

struct Reservation: Identifiable, Decodable {
    var id: UUID
    var status: String
}

struct CreateReservationDTO: Encodable {
    var workshopID: UUID
}
