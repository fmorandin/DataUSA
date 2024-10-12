//
//  StateDataViewModelTests.swift
//  Data USATests
//
//  Created by Felipe Morandin on 12/10/2024.
//

import XCTest
@testable import Data_USA

final class StateDataViewModelTests: XCTestCase {

    var viewModel: StateDataViewModel!

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    func testFetchStateDataViewModelSuccess() async throws {

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
        let mockService = MockStateDataService(mockData: mockJSON)
        viewModel = StateDataViewModel(service: mockService)

        // When
        await viewModel.fetchData()

        // Then
        XCTAssertEqual(viewModel.stateData.first?.idState, "04000US01")
        XCTAssertEqual(viewModel.stateData.first?.state, "Alabama")
        XCTAssertEqual(viewModel.stateData.first?.idYear, 2022)
        XCTAssertEqual(viewModel.stateData.first?.year, "2022")
        XCTAssertEqual(viewModel.stateData.first?.population, 5028092)
        XCTAssertEqual(viewModel.stateData.first?.slugState, "alabama")

        XCTAssertEqual(viewModel.sourceData.first?.measures.first, "Population")
        XCTAssertEqual(viewModel.sourceData.first?.annotations.sourceName, "Census Bureau")
        XCTAssertEqual(
            viewModel.sourceData.first?.annotations.sourceDescription,
            "The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year."
        )
    }

    func testFetchStateDataFailure() async throws {
        // Given
        let mockService = MockStateDataService(mockError: NetworkError.networkError(description: "Mock Error"))
        viewModel = StateDataViewModel(service: mockService)

        // When & Then
        await viewModel.fetchData()

        XCTAssertEqual(viewModel.errorMessage, "❌ Error fetching data: Mock Error")
    }
}
