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
    let baseUrl = "workshops"
    
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
    
    
    func getAvailableWorkshops(token: String) async -> [WorkshopWithReservation] {
        do {
            let workshops = try await webService.apiCall(
                url: "reservations/available",
                method: "GET",
                responseType: [WorkshopWithReservation].self,
                token: token
            )
            return workshops
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return []
    }
    
}
