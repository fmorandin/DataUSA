//
//  StateDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct StateDataView: View {

    private let viewModel = StateDataViewModel()

    var body: some View {
        Text("State Data")
            .font(.largeTitle)
            .fontWeight(.bold)
            .fontDesign(.monospaced)
            .onAppear {
                viewModel.fetchData()
            }
    }
}

#Preview {
    StateDataView()
}
