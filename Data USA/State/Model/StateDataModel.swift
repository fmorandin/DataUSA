//
//  StateDataModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

struct StateDataModel: Codable {
    let data: [StateData]
    // Same structure as the one present in the National Data Model
    let source: [SourceData]
}

struct StateData: Codable {
    let idState: String
    let state: String
    let idYear: Int
    let year: String
    let population: Int
    let slugState: String

    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
