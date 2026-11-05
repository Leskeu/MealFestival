//
//  APIError.swift
//  MealFestival
//
//  Created by Jules Liegeois on 04/11/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int, message: String)
    case emptyResponse

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Réponse HTTP invalide"
        case .httpError(let statusCode, let message):
            return "Erreur HTTP \(statusCode) : \(message)"
        case .emptyResponse:
            return "Le serveur a renvoyé une réponse vide"
        }
    }
}
