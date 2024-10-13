//
//  PopulationDataViewModelTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class PopulationDataViewModelTests: XCTestCase {

    var viewModel: PopulationDataViewModel!

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    func testFetchNationDataViewModelSuccess() async throws {

        // Given
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
        let mockService = MockPopulationDataService(mockData: mockJSON)
        viewModel = PopulationDataViewModel(service: mockService)

        // When
        await viewModel.fetchData(scope: .nation, timeInterval: nil)

        // Then
        XCTAssertEqual(viewModel.populationData.first?.idLocation, "01000US")
        XCTAssertEqual(viewModel.populationData.first?.location, "United States")
        XCTAssertEqual(viewModel.populationData.first?.idYear, 2022)
        XCTAssertEqual(viewModel.populationData.first?.year, "2022")
        XCTAssertEqual(viewModel.populationData.first?.population, 331097593)

        XCTAssertEqual(viewModel.sourceData.first?.measures.first, "Population")
        XCTAssertEqual(viewModel.sourceData.first?.annotations.sourceName, "Census Bureau")
        XCTAssertEqual(
            viewModel.sourceData.first?.annotations.sourceDescription,
            "The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year."
        )
    }

    func testNationDataFailure() async throws {

        // Given
        let mockService = MockPopulationDataService(mockError: NetworkError.networkError(description: "Mock Error"))
        viewModel = PopulationDataViewModel(service: mockService)


        // When & Then
        await viewModel.fetchData(scope: .nation, timeInterval: nil)

        XCTAssertEqual(viewModel.errorMessage, "❌ Error fetching data: Mock Error")
    }
}
