//
//  PopulationView.swift
//  Data USA
//
//  Created by Felipe Morandin on 14/10/2024.
//

import SwiftUI

struct PopulationView: View {

    let data: PopulationData

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(String(localized: "Location:"))
                    .bold()
                Text(data.location)
            }
            HStack {
                Text(String(localized: "Year:"))
                    .bold()
                Text(data.year)
            }
            HStack {
                Text(String(localized:"Population:"))
                    .bold()
                Text(String(data.population))
            }
        }
        .padding(.vertical)
    }
}
