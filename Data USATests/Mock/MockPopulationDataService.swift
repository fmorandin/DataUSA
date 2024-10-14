//
//  MockPopulationDataService.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

struct MockPopulationDataService: PopulationDataServiceProtocol {

    var mockData: Data? = nil
    var mockError: Error? = nil

    func fetchPopulationData(scope: ScopeOptions, timeInterval: TimeIntervalOptions?) async throws -> PopulationDataModel {

        if let error = mockError {
            throw error
        }

        guard let data = mockData else {
            throw NetworkError.networkError(description: "No mock data provided.")
        }

        return try JSONDecoder().decode(PopulationDataModel.self, from: data)
    }
}
