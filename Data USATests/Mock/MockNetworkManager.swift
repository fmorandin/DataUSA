//
//  MockNetworkManager.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

struct MockNetworkManager: NetworkManagerProtocol {

    var mockData: Data? = nil
    var mockError: Error? = nil

    func getData<T: Decodable>(for url: URL?, responseModel: T.Type) async throws -> T {

        if let error = mockError {
            throw error
        }

        guard let data = mockData else {
            throw NetworkError.networkError(description: "No mock data provided.")
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

}
