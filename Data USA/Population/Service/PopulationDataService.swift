//
//  PopulationDataService.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os

protocol PopulationDataServiceProtocol {
    
    func fetchPopulationData(scope: ScopeOptions, timeInterval: TimeIntervalOptions?) async throws -> PopulationDataModel
}

struct PopulationDataService: PopulationDataServiceProtocol {

    // MARK: - Private Variables

    private var networkManager: NetworkManagerProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: PopulationDataService.self)
    )

    // MARK: - Init

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {

        self.networkManager = networkManager
    }

    // MARK: - Public Methods

    func fetchPopulationData(scope: ScopeOptions, timeInterval: TimeIntervalOptions?) async throws -> PopulationDataModel {

        logger.notice("🛜 Starting to fetch the nation data.")

        var queryItems = [
            URLQueryItem(name: "drilldowns", value: scope.rawValue),
            URLQueryItem(name: "measures", value: "Population")
        ]

        if timeInterval != nil && timeInterval == .latestYear {
            queryItems.append(URLQueryItem(name: "year", value: timeInterval?.rawValue))
        }

        let url = constructURL(queryItems: queryItems)

        return try await networkManager.getData(for: url, responseModel: PopulationDataModel.self)
    }

    // MARK: - Private Methods

    private func constructURL(queryItems: [URLQueryItem]) -> URL? {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Endpoints.host.rawValue
        urlComponents.path = Endpoints.path.rawValue
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
}
