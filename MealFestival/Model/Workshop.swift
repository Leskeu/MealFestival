//
//  Workshop.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

struct Workshop : Identifiable{
    var id : UUID
    var workshopName : String
    var categoryId : Int
    var startTime : String
    var endTime : String
    var capacityMax : Int
    var totalSubscribers : Int
    var description : String
}
