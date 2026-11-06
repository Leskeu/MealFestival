//
//  WebService.swift
//  MealFestival
//
//  Created by Filip Rizov on 19/10/2026.
//

import Foundation

class WebService {
    private let session: URLSession
    private let apiRoot: String = "http://172.33.1.234:8081/"
    
    init(sessionConfig: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: sessionConfig)
    }
    
    func apiCall<T: Decodable>(
        url: String,
        method: String,
        queryParams: [String: String]? = nil,
        responseType: T.Type,
        body: Encodable? = nil,
        token: String? = nil
    ) async throws -> T {
        let data = try await performRequest(
            url: url,
            method: method,
            queryParams: queryParams,
            body: body,
            token: token
        )

        guard !data.isEmpty else {
            throw APIError.emptyResponse
        }

        return try JSONDecoder().decode(responseType, from: data)
    }

    func apiCallStatus(
        url: String,
        method: String,
        queryParams: [String: String]? = nil,
        body: Encodable? = nil,
        token: String? = nil
    ) async throws {
        _ = try await performRequest(
            url: url,
            method: method,
            queryParams: queryParams,
            body: body,
            token: token
        )
    }

    private func performRequest(
        url: String,
        method: String,
        queryParams: [String: String]?,
        body: Encodable?,
        token: String?
    ) async throws -> Data {
        guard var urlBuilder = URLComponents(string: self.apiRoot + url) else {
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
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            var message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)

            if let errorJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let reason = errorJSON["reason"] as? String {
                message = reason
            } else if let responseText = String(data: data, encoding: .utf8),
                      !responseText.isEmpty {
                message = responseText
            }

            throw APIError.httpError(statusCode: httpResponse.statusCode, message: message)
        }

        return data
    }
}
