//
//  MockNetworkManager.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
@testable import Data_USA

struct MockNetworkManager: NetworkManagerProtocol {

    var mockData: Data? = nil
    var mockError: Error? = nil

    func getData<T>(for urlString: String, responseModel: T.Type) async throws -> T where T : Decodable {

        if let error = mockError {
            throw error
        }

        guard let data = mockData else {
            throw NetworkError.networkError(description: "No mock data provided.")
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

}
