//
//  montserratExtension.swift
//  MealFestival
//
//  Created by Filip Rizov on 06/10/2026.
//

import SwiftUI

extension Font {
    enum MontserratWeight {
        case regular
        case semibold
        case extrabold
        
        var name: String {
            switch self {
            case .regular: return "Montserrat-Regular"
            case .semibold: return "Montserrat-Bold"
            case .extrabold: return "Montserrat-ExtraBold"
            }
        }
    }

    static func montserrat(_ weight: MontserratWeight, size: Double) -> Font {
        return .custom(weight.name, size: size)
    }
}
