//
//  NetworkManager.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os

// Protocol to make it easier to test
protocol NetworkManagerProtocol {

    func getData<T: Decodable>(for urlString: String, responseModel: T.Type) async throws -> T
}

struct NetworkManager: NetworkManagerProtocol {

    // MARK: - Private Variables

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NetworkManager.self)
    )

    // MARK: - Public Methods

    func getData<T: Decodable>(for urlString: String, responseModel: T.Type) async throws -> T {

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        logger.notice("🛜 Starting the request for url \(url).")

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(responseModel.self, from: data)
            logger.notice("🛜 Data successfully fetched and decoded.")
            return decodedData
        } catch {
            logger.error("❌ Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(description: error.localizedDescription)
        }
    }
}
