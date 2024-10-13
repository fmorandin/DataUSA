//
//  MainView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct MainView: View {
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

                NavigationLink(destination: NationDataView(), label: {
                    HStack {
                        Image(systemName: "person.3")
                        Text("National Data")
                    }
                    .font(.callout)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                })
                .padding(.bottom)

                NavigationLink(destination: StateDataView(), label: {
                    HStack {
                        Image(systemName: "person.2")
                        Text("State Data")
                    }
                    .font(.callout)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                })

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
