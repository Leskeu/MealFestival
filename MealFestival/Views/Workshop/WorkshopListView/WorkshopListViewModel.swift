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

    var workshops: [WorkshopWithReservation] = []

    private let workshopRepository = WorkshopRepository()

    func getWorkshops(token: String) async {
        workshops = await workshopRepository.getAvailableWorkshops(token: token)
    }
    
    
}
