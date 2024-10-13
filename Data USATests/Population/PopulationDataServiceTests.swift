//
//  PopulationDataServiceTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class PopulationDataServiceTests: XCTestCase {

    var service: PopulationDataService!

    override func tearDown() {

        service = nil

        super.tearDown()
    }

    func testFetchNationDataServiceSuccess() async throws {

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
        let mockNetworkManager = MockNetworkManager(mockData: mockData)
        service = PopulationDataService(networkManager: mockNetworkManager)

        do {
            let result = try await service.fetchPopulationData(scope: .nation, timeInterval: nil)

            XCTAssertEqual(result.data.first?.idLocation, "01000US")
            XCTAssertEqual(result.data.first?.location, "United States")
            XCTAssertEqual(result.data.first?.idYear, 2022)
            XCTAssertEqual(result.data.first?.year, "2022")
            XCTAssertEqual(result.data.first?.population, 331097593)

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

    func testFetchNationDataServiceFailure() async throws {

        let mockNetworkManager = MockNetworkManager(mockError: NetworkError.invalidURL)
        service = PopulationDataService(networkManager: mockNetworkManager)

        do {
            let _ = try await service.fetchPopulationData(scope: .nation, timeInterval: nil)
            XCTFail("Expected to throw, but did not.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The URL is invalid.")
        }
    }
}
