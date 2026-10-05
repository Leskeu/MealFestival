//
//  User.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

struct User : Identifiable {
    var id : UUID
    var userName : String
    var password : String
    var email : String
    var role : String
    var created_date : Date
}
