//
//  NationDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct NationDataView: View {

    @StateObject var viewModel = NationDataViewModel()

    var body: some View {
        VStack {

            Text(String(localized: "Nation Data"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.monospaced)
                .padding(.top)

            if let errorMessage = viewModel.errorMessage {
                Text(String(localized: "Error: \(errorMessage)"))
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.nationData, id: \.idYear) { data in
                    VStack(alignment: .leading) {
                        Text(String(localized: "Nation: \(data.nation)"))
                        Text(String(localized: "Year: \(data.year)"))
                        Text(String(localized:"Population: \(data.population)"))
                    }
                    .listRowBackground(Color.black.opacity(0.1))
                    .padding()
                }
                .scrollContentBackground(.hidden)
                .padding()
            }
        }
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
