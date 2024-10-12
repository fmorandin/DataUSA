//
//  StateDataServiceTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class StateDataServiceTests: XCTestCase {

    var service: StateDataService!

    override func tearDown() {

        service = nil

        super.tearDown()
    }

    func testFetchStateDataServiceSuccess() async throws {

        // Given
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
        let mockNetworkManager = MockNetworkManager(mockData: mockJSON)
        service = StateDataService(networkManager: mockNetworkManager)

        do {
            let result = try await service.fetchStateData()

            XCTAssertEqual(result.data.first?.idState, "04000US01")
            XCTAssertEqual(result.data.first?.state, "Alabama")
            XCTAssertEqual(result.data.first?.idYear, 2022)
            XCTAssertEqual(result.data.first?.year, "2022")
            XCTAssertEqual(result.data.first?.population, 5028092)
            XCTAssertEqual(result.data.first?.slugState, "alabama")

            XCTAssertEqual(result.source.first?.measures.first, "Population")
            XCTAssertEqual(result.source.first?.annotations.sourceName, "Census Bureau")
            XCTAssertEqual(
                result.source.first?.annotations.sourceDescription,
                "The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year."
            )
        } catch {
            XCTFail("Should not throw")
        }
    }

    func testFetchStateDataServiceFailure() async throws {

        let mockNetworkManager = MockNetworkManager(mockError: NetworkError.invalidURL)
        service = StateDataService(networkManager: mockNetworkManager)

        do {
            let _ = try await service.fetchStateData()
            XCTFail("Expected to throw, but did not.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The URL is invalid.")
        }
    }
}
