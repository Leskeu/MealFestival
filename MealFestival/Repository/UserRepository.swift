//
//  UserRepository.swift.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

@MainActor
@Observable
final class UserRepository {
    
    let webService = WebService()
    
    //get token from login form
    func getToken(loginRequestDTO: LoginRequestDTO) async -> UserToken? {
        do {
            let user = try await webService.apiCall(
                url: "/login",
                method: "POST",
                responseType: UserToken.self,
                body: loginRequestDTO
            )
            return user
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return nil
    }
    //register form
    func register(registerResquest: RegisterRequestDTO) async -> UserDTO? {
        do {
            let user : UserDTO = try await webService.apiCall(
                url: "/users",
                method: "POST",
                responseType: UserDTO.self,
                body: registerResquest, 
            )
            return user
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return nil
    }
    
}
