//
//  regiterRepository.swift
//  MealFestival
//
//  Created by Awatef on 04/11/2026.
//
import Foundation

@MainActor
@Observable

final class RegisterRepository {
    let webService = WebService()
    //register from register form
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
