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
    let baseUrl = "http://localhost:8081"
    
    //get token from login form
    func getToken(loginRequestDTO: LoginRequestDTO) async -> UserToken? {
        do {
            let user = try await webService.apiCall(
                url: self.baseUrl+"/login",
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
    
}
