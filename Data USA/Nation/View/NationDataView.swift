//
//  NationDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct NationDataView: View {

    // MARK: - State Public Variables

    @StateObject var viewModel = NationDataViewModel()

    // MARK: - State Private Variables

    @State private var searchText: String = ""

    // MARK: - Private Variables

    private var filteredData: [NationData] {
        if searchText.isEmpty {
            return viewModel.nationData
        } else {
            return viewModel.nationData.filter { $0.year.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // MARK: - UI

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(String(localized: "Error: \(errorMessage)"))
                    .foregroundColor(.red)
                    .padding()
            } else {
                if filteredData.count > 1 {
                    List(filteredData, id: \.idYear) { data in
                        VStack(alignment: .leading) {
                            Text(String(localized: "Nation: \(data.nation)"))
                            Text(String(localized: "Year: \(data.year)"))
                            Text(String(localized:"Population: \(data.population)"))
                        }
                        .listRowBackground(Color.black.opacity(0.1))
                        .padding()
                    }
                    .searchable(
                        text: $searchText,
                        prompt: String(localized: "Search by Year")
                    )
                    .scrollContentBackground(.hidden)
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
        .navigationTitle(String(localized: "Nation Data"))
        .navigationBarTitleDisplayMode(.large)
        .background(Color.black.opacity(0.1))
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
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
                },
                {
                    "ID Nation": "01000US",
                    "Nation": "United States",
                    "ID Year": 2021,
                    "Year": "2021",
                    "Population": 329725481,
                    "Slug Nation": "united-states"
                },
                {
                    "ID Nation": "01000US",
                    "Nation": "United States",
                    "ID Year": 2020,
                    "Year": "2020",
                    "Population": 326569308,
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
    let mockNetworkManager = MockNationDataService(mockData: mockData)
    NationDataView(viewModel: NationDataViewModel(service: mockNetworkManager))
}
