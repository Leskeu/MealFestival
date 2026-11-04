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

struct UserToken: Decodable {
    var token: String
}

struct LoginRequestDTO: Encodable {
    let email: String
    let password: String
}


struct RegisterRequestDTO: Encodable {
    let name: String
    let email: String
    let password: String
}

struct UserDTO: Decodable {
    let id: UUID
    let name: String
    let email: String
}
