//
//  WorkshopRepository.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

final class WorkshopRepository {
    
    //get all workshops
    func getWorkshops() async -> [Category] {
        let service = WebService()
        do {
            let workshops = try await service.apiCall(
                url: "http://localhost:8081/workshops",
                method: "GET",
                responseType: [Category].self
            )
            return workshops
            
        } catch {
            print("Erreur API : \(error.localizedDescription)")
        }
        return []
    }
    
}
