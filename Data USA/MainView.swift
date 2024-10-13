//
//  MainView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct MainView: View {

    // MARK: - State Private Variables

    @State private var scope = ScopeOptions.nation
    @State private var timeInterval = TimeIntervalOptions.allYears

    // MARK: - UI
    
    var body: some View {
        NavigationView {
            VStack { 
                Image(systemName: "rectangle.and.text.magnifyingglass")
                    .resizable()
                    .frame(width: 50, height: 40)
                    .padding(.top, 50)
                    .padding(.bottom, 10)

                Text(String(localized: "Select the data you want to see"))
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 30)

                VStack(alignment: .leading) {
                    HStack {
                        Text(String(localized: "Population:"))
                        Picker("Scope", selection: $scope) {
                            ForEach(ScopeOptions.allCases) {
                                Text($0.title)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    HStack {
                        Text(String(localized: "Period:"))
                        Picker("Time Interval", selection: $timeInterval) {
                            ForEach(TimeIntervalOptions.allCases) {
                                Text($0.title)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }

                NavigationLink(destination: PopulationDataView(scope: scope, timeInterval: timeInterval), label: {
                    HStack {
                        Image(systemName: "person.3")
                        Text("Get Data")
                    }
                    .font(.callout)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                })
                .padding(.bottom)

                Spacer()
            }
            .navigationTitle(String(localized: "Data USA"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    MainView()
}
