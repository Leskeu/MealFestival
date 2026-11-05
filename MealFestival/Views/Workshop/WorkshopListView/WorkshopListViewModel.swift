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
    private let userStore = UserStore()
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmF0aW9uIjoxNzkzODg2MDk3Ljg0MjM3NiwiaWQiOiI0QzEwNzA3Qi00NDI1LTRFRTktQUMzRC1BRDFDMkFCNUY0NEYifQ.xpwvTtf6UPKtMGuwnEiWlIh5EjceOY5c_Ch3YYKIBqQ"

    func getWorkshops() async {
        workshops = await workshopRepository.getUnReservedWorkshopFromUser(token: token)
        if let token = userStore.token {
            workshops = await workshopRepository.getUnReservedWorkshopFromUser(token: token)
        }
    }
    
    func getReservedWorkshops() async {
        workshops = await workshopRepository.getReservedWorkshopFromUser(token: token)
        if let token = userStore.token {
            workshops = await workshopRepository.getReservedWorkshopFromUser(token: token)
        }
    }
    
    
}
