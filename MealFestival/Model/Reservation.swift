//
//  Reservation.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation
struct Reservation : Identifiable{
    var id : UUID
    var worshopId : Int
    var userId : Int
    var status : String
}
