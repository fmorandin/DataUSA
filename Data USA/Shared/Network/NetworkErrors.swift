//
//  NetworkErrors.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

enum NetworkError: LocalizedError {

    case invalidURL
    case networkError(description: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .networkError(let description):
            return description
        }
    }
}
