//
//  SourceView.swift
//  Data USA
//
//  Created by Felipe Morandin on 13/10/2024.
//

import SwiftUI

struct SourceView: View {

    // MARK: - Public Variables

    var sourceData: SourceData?

    // MARK: - UI

    var body: some View {
        
        if let sourceName = sourceData?.annotations.sourceName,
           let sourceDescription = sourceData?.annotations.sourceDescription {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(String(localized: "Source:"))
                        .bold()
                    Text(sourceName)
                }

                Text(sourceDescription)

            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding()
        }

    }

}
