//
//  WorkshopRepository.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

@MainActor
@Observable
final class WorkshopRepository {
    
    let webService = WebService()
    let baseUrl = "http://localhost:8081/workshops"
    
    //get all workshops
    func getWorkshops() async -> [Workshop] {
        do {
            let workshops = try await webService.apiCall(
                url: self.baseUrl,
                method: "GET",
                responseType: [Workshop].self
            )
            return workshops
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return []
    }
    
    //get workshops reserved from an user
    func getReservedWorkshopFromUser(userToken: UserToken) async -> [Workshop] {
        do {
            let workshops = try await webService.apiCall(
                url: self.baseUrl+"/reservations",
                method: "GET",
                responseType: [Workshop].self,
                token: userToken.token
            )
            return workshops
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return []
    }
    
}
