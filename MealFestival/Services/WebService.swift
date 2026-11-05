//
//  WebService.swift
//  MealFestival
//
//  Created by Filip Rizov on 19/10/2026.
//

import Foundation


class WebService {
    private let session: URLSession
    private let apiRoot: String = "http://localhost:8081/"//adresse backend
    
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
        //constructs the complete address
        guard var urlBuilder = URLComponents(string: self.apiRoot + url) else {
            throw URLError(.badURL)
        }
        //add parameters to the URL
        if let queryParams {
            urlBuilder.queryItems = queryParams.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        //retrieve the final URL
        guard let finalUrl = urlBuilder.url else {
            throw URLError(.badURL)
        }
        //prepare the request and the method
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method
        //add token in the header
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        //add body json, the data sent to the backend
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
      //  Send the request to the server
        
        let (data, response) =  try await URLSession.shared.data(for: request)
        //verify the anwser
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
            case 200...299:
                let result = try JSONDecoder().decode(responseType, from: data)
                return result
            default:
            let errorResponse = String(data: data, encoding: .utf8) ?? ""

             throw NSError(
                 domain: "APIError",
                 code: httpResponse.statusCode,
                 userInfo: [NSLocalizedDescriptionKey: errorResponse]
             )        }
    }
}
//URLSession    Communiquer avec le serveur.
//URLRequest    Préparer une requête HTTP.
//URLComponents    Construire une URL.
//URLQueryItem    Ajouter des paramètres à une URL.
//JSONEncoder    Transformer un objet Swift en JSON.
//JSONDecoder    Transformer du JSON en objet Swift.
//HTTPURLResponse    Lire la réponse HTTP du serveur.
