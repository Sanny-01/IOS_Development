//
//  APIManager.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 30.08.22.
//

import Foundation

import Foundation

final class APIManager {
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type) async throws -> T {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        
        let (data, response) = try await session.data(from: url)
        print(response)
        guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else { throw ApiError.httpError }
        
        do {
           return try JSONDecoder().decode(decodingType.self, from: data)
        } catch {
            throw ApiError.decodingError
        }
    }
}
