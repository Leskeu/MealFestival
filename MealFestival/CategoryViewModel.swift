//
//  CategoryViewModel.swift
//  MealFestival
//
//  Created by Filip Rizov on 19/10/2026.
//

import Foundation

@MainActor
@Observable
final class RegisterViewModel: Sendable {
    
    func getWorkshops() async -> [Category] {
        let service = WebService()
        do {
            let categories = try await service.apiCall(
                url: "http://localhost:8081/workshops",
                method: "GET",
                responseType: [Category].self
            )
            return categories
            
        } catch {
            print("Erreur API : \(error.localizedDescription)")
        }
        return []
    }
}
