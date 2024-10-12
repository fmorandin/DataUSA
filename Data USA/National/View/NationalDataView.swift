//
//  NationalDataView.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import SwiftUI

struct NationalDataView: View {

    private var viewModel = NationalDataViewModel()

    var body: some View {
        Text("National Data")
            .font(.largeTitle)
            .fontWeight(.bold)
            .fontDesign(.monospaced)
            .onAppear {
                viewModel.fetchData()
            }
    }
}

#Preview {
    NationalDataView()
}
