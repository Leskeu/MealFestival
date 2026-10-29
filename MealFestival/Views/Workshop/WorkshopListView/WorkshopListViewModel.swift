//
//  WorkshopListViewModel.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation
import Observation

@Observable
class WorkshopViewModel {

    var workshops: [Workshop] = []

    private let workshopRepository = WorkshopRepository()

    func getWorkshops() async {
        workshops = await workshopRepository.getWorkshops()
    }
    
    
    func getReservedWorkshops(token: String) async {
        workshops = await workshopRepository.getReservedWorkshopFromUser(token: token)
    }
}
