//
//  Workshop.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

struct Workshop : Identifiable, Decodable, Equatable {
    var id : UUID
    var name : String
    var categoryName : String
    var startTime : String
    var endTime : String
    var maxCapacity : Int
    var totalSubscribers : Int
    var availableSpot : Int
    var description : String
}

struct WorkshopWithReservation: Identifiable, Decodable {
    var workshopDTO: Workshop
    var reservationDTO: Reservation?

    var id: UUID { workshopDTO.id }
}
