//
//  WorkshopReservationViewModel.swift
//  MealFestival
//
//  Created by Awatef on 05/10/2026.
//

import Foundation
import SwiftUI

@Observable
class WorkshopViewModel {
    
    
    func buttonColor(_ workshopStatus: String) -> Color {
        switch workshopStatus {
        case "Reserved":
            return Color.jungle
        case "Cancel":
            return Color.brick
        default:
            return Color.charcoal
        }
    }
    func buttonForm(_ workshopStatus: String) -> UnevenRoundedRectangle {
        switch workshopStatus {
        case "Reserved":
            return UnevenRoundedRectangle(
                topLeadingRadius: 25,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 25,
                topTrailingRadius: 8,
                style: .continuous
                )
        case "Cancel":
            return UnevenRoundedRectangle(
                topLeadingRadius: 8,
                bottomLeadingRadius: 25,
                bottomTrailingRadius: 8,
                topTrailingRadius: 25,
                style: .continuous
                )
        default:
            return UnevenRoundedRectangle(
                topLeadingRadius: 25,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 25,
                topTrailingRadius: 8,
                style: .continuous
                )
        }
    }
    
}
