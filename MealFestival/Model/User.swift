//
//  User.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

struct User : Identifiable, Decodable {
    var id : UUID
    var name : String
    var email : String
    var role : String
    var createdAt : Date
}

struct UserToken: Decodable {
    var token: String
}

struct LoginRequestDTO: Encodable {
    let email: String
    let password: String
}

struct RegisterRequestDTO: Encodable {
    let email: String
    let password: String
    let name: String
}
