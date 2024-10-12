//
//  StateDataServiceTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class StateDataServiceTests: XCTestCase {

    var mockService = MockStateDataService()

    func testFetchStateDataSuccess() async throws {

        let mockJSON = """
        {
            "data": [
                {
                    "ID State": "04000US01",
                    "State": "Alabama",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 5028092,
                    "Slug State": "alabama"
                }
            ],
            "source": [
                {
                    "measures": [
                        "Population"
                    ],
                    "annotations": {
                        "source_name": "Census Bureau",
                        "source_description": "The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year.",
                    }
                }
            ]
        }
        """.data(using: .utf8)!
        mockService.mockData = mockJSON

        // When
        let result = try await mockService.fetchStateData()

        // Then
        XCTAssertEqual(result.data.first?.idState, "04000US01")
        XCTAssertEqual(result.data.first?.state, "Alabama")
        XCTAssertEqual(result.data.first?.idYear, 2022)
        XCTAssertEqual(result.data.first?.year, "2022")
        XCTAssertEqual(result.data.first?.population, 5028092)
        XCTAssertEqual(result.data.first?.slugState, "alabama")
    }

    func testFetchStateDataFailure() async throws {
        // Given
        mockService.mockError = NetworkError.networkError(description: "Mock Error")

        // When & Then
        do {
            let _ = try await mockService.fetchStateData()
            XCTFail("Expected to throw, but did not.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Mock Error")
        }
    }
}
