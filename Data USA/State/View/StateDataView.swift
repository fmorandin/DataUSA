//
//  StateDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct StateDataView: View {

    // MARK: - State Public Variables
    
    @StateObject var viewModel = StateDataViewModel()

    // MARK: - State Private Variables

    @State private var searchText: String = ""
    @FocusState private var isTextFieldFocused: Bool

    // MARK: - Private Variables

    private var filteredData: [StateData] {
        if searchText.isEmpty {
            return viewModel.stateData
        } else {
            return viewModel.stateData.filter { $0.state.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // MARK: - UI

    var body: some View {
        VStack {
            SearchBarView(prompt: "Search by State", searchText: $searchText, isFocused: $isTextFieldFocused)

            if let errorMessage = viewModel.errorMessage {
                Text(String(localized: "Error: \(errorMessage)"))
                    .foregroundColor(.red)
                    .padding()
            } else {
                if !filteredData.isEmpty {
                    List(filteredData, id: \.idState) { data in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(String(localized: "State:"))
                                    .bold()
                                Text(data.state)
                            }
                            HStack {
                                Text(String(localized: "Year:"))
                                    .bold()
                                Text(data.year)
                            }
                            HStack {
                                Text(String(localized: "Population:"))
                                    .bold()
                                Text(String(data.population))
                            }
                        }
                        .padding(.vertical)
                    }
                    .scrollContentBackground(.hidden)

                    SourceView(sourceData: viewModel.sourceData.first)

                } else {
                    if #available(iOS 17.0, *) {
                        ContentUnavailableView(
                            String(localized: "No Data Found"),
                            systemImage: "exclamationmark.triangle.fill"
                        )
                    } else {
                        EmptyView()
                    }
                }
            }
        }
        .navigationTitle(String(localized: "State Data"))
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

#Preview {
    let mockData = """
        {
            "data": [
                {
                    "ID State": "04000US01",
                    "State": "Alabama",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 5028092,
                    "Slug State": "alabama"
                },
                {
                    "ID State": "04000US06",
                    "State": "California",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 39356104,
                    "Slug State": "california"
                },
                {
                    "ID State": "04000US11",
                    "State": "District of Columbia",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 670587,
                    "Slug State": "district-of-columbia"
                },
                {
                    "ID State": "04000US12",
                    "State": "Florida",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 21634529,
                    "Slug State": "florida"
                },
                {
                    "ID State": "04000US36",
                    "State": "New York",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 19994379,
                    "Slug State": "new-york"
                },
                {
                    "ID State": "04000US48",
                    "State": "Texas",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 29243342,
                    "Slug State": "texas"
                },
                {
                    "ID State": "04000US49",
                    "State": "Utah",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 3283809,
                    "Slug State": "utah"
                },
                {
                    "ID State": "04000US50",
                    "State": "Vermont",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 643816,
                    "Slug State": "vermont"
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
    let mockNetworkManager = MockStateDataService(mockData: mockData)
    StateDataView(viewModel: StateDataViewModel(service: mockNetworkManager))
}
