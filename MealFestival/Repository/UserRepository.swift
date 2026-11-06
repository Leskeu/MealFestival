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
    
    func registerUser(registerRequest: RegisterRequestDTO) async -> UserToken? {
        do {
            let user = try await webService.apiCall(
                url: "/register",
                method: "POST",
                responseType: User.self,
                body: registerRequest
            )
    
            let token = try await webService.apiCall(
                url: "/login",
                method: "POST",
                responseType: UserToken.self,
                body: LoginRequestDTO(email: registerRequest.email, password: registerRequest.password)
            )
            
            return token
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return nil
    }
    
}
