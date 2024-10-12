//
//  NationTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class NationDataServiceTests: XCTestCase {

    var mockService = MockNationDataService()

    func testFetchNationDataSuccess() async throws {

        let mockJSON = """
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
        mockService.mockData = mockJSON

        // When
        let result = try await mockService.fetchNationData()

        // Then
        XCTAssertEqual(result.data.first?.idNation, "01000US")
        XCTAssertEqual(result.data.first?.nation, "United States")
        XCTAssertEqual(result.data.first?.idYear, 2022)
        XCTAssertEqual(result.data.first?.year, "2022")
        XCTAssertEqual(result.data.first?.population, 331097593)
        XCTAssertEqual(result.data.first?.slugNation, "united-states")
    }

    func testFetchNationDataFailure() async throws {
        // Given
        mockService.mockError = NetworkError.networkError(description: "Mock Error")

        // When & Then
        do {
            let _ = try await mockService.fetchNationData()
            XCTFail("Expected to throw, but did not.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Mock Error")
        }
    }
}
