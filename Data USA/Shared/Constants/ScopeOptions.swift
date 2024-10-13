//
//  ScopeOptions.swift
//  Data USA
//
//  Created by Felipe Morandin on 13/10/2024.
//

import Foundation

enum ScopeOptions: String, CaseIterable, Identifiable {

    case nation = "Nation"
    case state = "State"

    var id: Self { self }

    var title: String {
        switch self {
        case .nation: 
            return "Nation"
        case .state: 
            return "State"
        }
    }
}
