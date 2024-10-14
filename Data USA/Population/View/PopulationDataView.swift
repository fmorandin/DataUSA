//
//  PopulationDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct PopulationDataView: View {

    // MARK: - State Public Variables

    @StateObject var viewModel = PopulationDataViewModel()
    @Environment(\.presentationMode) var presentationMode

    // MARK: - State Private Variables

    @State private var searchText = ""
    @State private var isLoading = false
    @State private var hasErrors = false
    @FocusState private var isTextFieldFocused: Bool

    // MARK: - Public Variables

    var scope: ScopeOptions = .nation
    var timeInterval: TimeIntervalOptions?

    // MARK: - Private Variables

    private var filteredData: [PopulationData] {
        if searchText.isEmpty {
            return viewModel.populationData
        } else {
            return viewModel.populationData.filter { item in
                item.year.localizedCaseInsensitiveContains(searchText) ||
                item.location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - UI

    var body: some View {
        VStack {

            if isLoading {
                ProgressView(String(localized: "Loading"))
                    .progressViewStyle(.circular)
                    .padding()
            } else {

                SearchBarView(
                    prompt: "Search by Year or Location",
                    searchText: $searchText, isFocused: $isTextFieldFocused
                )

                if !filteredData.isEmpty {
                    List(filteredData, id: \.id) { data in
                        PopulationView(data: data)
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
        .navigationTitle(String(localized: "Population Data"))
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            isLoading = true
            Task {
                await viewModel.fetchData(scope: scope, timeInterval: timeInterval)
                self.isLoading = false
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
        .onChange(of: viewModel.errorMessage ?? "") { errorMessage in
            hasErrors = !errorMessage.isEmpty
        }
        .alert(isPresented: $hasErrors, content: {
            Alert(
                title: Text(String(localized: "Error")),
                message: Text(viewModel.errorMessage ?? String(localized: "Sorry, something went wrong.\nPlease try again later.")),
                dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                })
            )
        })
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
    let mockNetworkManager = MockPopulationDataService(mockData: mockData)
    PopulationDataView(viewModel: PopulationDataViewModel(service: mockNetworkManager))
}
