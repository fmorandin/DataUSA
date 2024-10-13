//
//  StateDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct StateDataView: View {

    @StateObject var viewModel = StateDataViewModel()

    var body: some View {
        VStack {

            Text(String(localized: "State Data"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.monospaced)
                .padding(.top)

            if let errorMessage = viewModel.errorMessage {
                Text(String(localized: "Error: \(errorMessage)"))
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.stateData, id: \.idState) { data in
                    VStack(alignment: .leading) {
                        Text(String(localized: "State: \(data.state)"))
                        Text(String(localized: "Year: \(data.year)"))
                        Text(String(localized: "Population: \(data.population)"))
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
