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
                Text("Data USA")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                
                Spacer()

                NavigationLink(destination: NationDataView(), label: {
                    HStack {
                        Image(systemName: "globe.americas.fill")
                        Text("National Data")
                    }
                    .font(.callout)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .foregroundColor(.purple)
                    .cornerRadius(10)
                })
                .padding(.bottom)

                NavigationLink(destination: StateDataView(), label: {
                    HStack {
                        Image(systemName: "mappin.circle")
                        Text("State Data")
                    }
                    .font(.callout)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .foregroundColor(.purple)
                    .cornerRadius(10)
                })

                Spacer()
            }
            .padding()
        }
    }

}

#Preview {
    MainView()
}
