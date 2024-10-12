//
//  StateDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct StateDataView: View {

    @StateObject private var viewModel = StateDataViewModel()

    var body: some View {
        Text("State Data")
            .font(.largeTitle)
            .fontWeight(.bold)
            .fontDesign(.monospaced)
            .onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
    }
}

#Preview {
    StateDataView()
}
