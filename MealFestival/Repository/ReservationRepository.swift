//
//  ReservationRepository.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation

@MainActor
@Observable
final class ReservationRepository {
    
    let webService = WebService()
    let baseUrl = "reservations"
    
    //participate
    func askToParticipate(createReservationDTO: CreateReservationDTO, token: String) async -> Bool {
        do {
            let reservation = try await webService.apiCallStatus(
                url: self.baseUrl + "/participate",
                method: "POST",
                body: createReservationDTO,
                token: token
            )
            
            return true
            
        } catch {
            print("Erreur API : \(error.localizedDescription), \(error)")
        }
        return false
    }
    
    //cancel
    
    
    
}
