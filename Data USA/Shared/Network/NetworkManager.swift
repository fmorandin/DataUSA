//
//  NetworkManager.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os
import Combine

// Protocol to make it easier to test
protocol NetworkManagerProtocol {

    func getData<T: Decodable>(for urlString: String, responseModel: T.Type) -> AnyPublisher<T, Error>
}

// Enum that will hold the possible error cases
enum ErrorCases: Error {

    case invalidUrl, genericError, unauthorized, decode, requestError, forbidden
}

struct NetworkManager: NetworkManagerProtocol {

    // MARK: - Private Variables

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NetworkManager.self)
    )

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Public Methods

    func getData<T: Decodable>(for urlString: String, responseModel: T.Type) -> AnyPublisher<T, Error> {

        guard let url = URL(string: urlString) else { return Fail(error: ErrorCases.invalidUrl).eraseToAnyPublisher() }

        logger.notice("🛜 Starting the request for url \(url).")

        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                Fail(error: error).eraseToAnyPublisher()
            }
            .map { $0.data }
            .decode(type: responseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
