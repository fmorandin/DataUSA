//
//  NetworkManagerTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class NetworkManagerTests: XCTestCase {

    var mockNetworkManager = MockNetworkManager()

    func testGetNationDataSuccess() async throws {

        // Given
        let mockData = """
        {
            "data": [
                {
                    "ID Nation": "01000US",
                    "Nation": "United States",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 331097593,
                    "Slug Nation": "united-states"
                }
            ],
            "source": [
                {
                    "measures": ["Population"],
                    "annotations": {
                            "source_name": "Census Bureau",
                            "source_description": "The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year.",
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        mockNetworkManager.mockData = mockData

        // When
        let result = try await mockNetworkManager.getData(for: URL(string: "url")!, responseModel: PopulationDataModel.self)

        // Then
        XCTAssertEqual(result.data.first?.idLocation, "01000US")
        XCTAssertEqual(result.data.first?.location, "United States")
        XCTAssertEqual(result.data.first?.idYear, 2022)
        XCTAssertEqual(result.data.first?.year, "2022")
        XCTAssertEqual(result.data.first?.population, 331097593)
    }

    func testFetchNationDataFailure() async throws {
        // Given
        mockNetworkManager.mockError = NetworkError.networkError(description: "Mock Error")

        // When & Then
        do {
            let _ = try await mockNetworkManager.getData(for: URL(string: "url")!, responseModel: Data.self)
            XCTFail("Expected to throw, but did not.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Mock Error")
        }
    }
}
