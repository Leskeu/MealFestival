//
//  WebService.swift
//  MealFestival
//
//  Created by Filip Rizov on 19/10/2026.
//

import Foundation


class WebService {
    private let session: URLSession
    
    init(sessionConfig: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: sessionConfig)
    }
    
    func apiCall<T:Decodable>(
        url: String,
        method: String,
        queryParams: [String: String]? = nil,
        responseType: T.Type,
        body: Encodable? = nil,
        token: String? = nil
    ) async throws -> T {
        guard var urlBuilder = URLComponents(string: url) else {
            throw URLError(.badURL)
        }
        
        if let queryParams {
            urlBuilder.queryItems = queryParams.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let finalUrl = urlBuilder.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method
        
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) =  try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
            case 200...299:
                let result = try JSONDecoder().decode(responseType, from: data)
                return result
            default:
                throw URLError(.badServerResponse)
        }
    }
}
