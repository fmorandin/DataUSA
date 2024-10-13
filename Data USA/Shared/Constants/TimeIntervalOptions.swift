//
//  TimeIntervalOptions.swift
//  Data USA
//
//  Created by Felipe Morandin on 13/10/2024.
//

import Foundation

enum TimeIntervalOptions: String, CaseIterable, Identifiable {

    case latestYear = "latest"
    case allYears

    var id: Self { self }

    var title: String {
        switch self {
        case .latestYear: 
            return "Latest Year"
        case .allYears: 
            return "All Years"
        }
    }
}
