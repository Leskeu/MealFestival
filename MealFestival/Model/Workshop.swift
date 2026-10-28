//
//  Workshop.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

struct Workshop : Identifiable, Decodable {
    var id : UUID
    var name : String
    var categoryName : String
    var startTime : String
    var endTime : String
    var maxCapacity : Int
    var totalSubscribers : Int
    var description : String
}
