//
//  NationDataViewModelTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class NationDataViewModelTests: XCTestCase {

    var viewModel: NationDataViewModel!

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
        let mockService = MockNationDataService(mockData: mockJSON)
        viewModel = NationDataViewModel(service: mockService)

        // When
        await viewModel.fetchData()

        // Then
        XCTAssertEqual(viewModel.nationData.first?.idNation, "01000US")
        XCTAssertEqual(viewModel.nationData.first?.nation, "United States")
        XCTAssertEqual(viewModel.nationData.first?.idYear, 2022)
        XCTAssertEqual(viewModel.nationData.first?.year, "2022")
        XCTAssertEqual(viewModel.nationData.first?.population, 331097593)
        XCTAssertEqual(viewModel.nationData.first?.slugNation, "united-states")

        XCTAssertEqual(viewModel.sourceData.first?.measures.first, "Population")
        XCTAssertEqual(viewModel.sourceData.first?.annotations.sourceName, "Census Bureau")
        XCTAssertEqual(
            viewModel.sourceData.first?.annotations.sourceDescription,
            "The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year."
        )
    }

    func testNationDataFailure() async throws {
        // Given
        let mockService = MockNationDataService(mockError: NetworkError.networkError(description: "Mock Error"))
        viewModel = NationDataViewModel(service: mockService)


        // When & Then
        await viewModel.fetchData()

        XCTAssertEqual(viewModel.errorMessage, "❌ Error fetching data: Mock Error")
    }
}
