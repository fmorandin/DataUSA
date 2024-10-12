//
//  MockStateDataService.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
@testable import Data_USA

struct MockStateDataService: StateDataServiceProtocol {
    
    var mockData: Data? = nil
    var mockError: Error? = nil

    func fetchStateData() async throws -> StateDataModel {

        if let error = mockError {
            throw error
        }

        guard let data = mockData else {
            throw NetworkError.networkError(description: "No mock data provided.")
        }

        return try JSONDecoder().decode(StateDataModel.self, from: data)
    }
}
