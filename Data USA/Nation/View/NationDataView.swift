//
//  NationDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct NationDataView: View {

    @StateObject private var viewModel = NationDataViewModel()

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Nation Data")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    NationDataView()
}
