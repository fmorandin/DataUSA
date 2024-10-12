//
//  NationalDataModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

struct NationalDataModel: Codable {
    let data: [NationalData]
    let source: [SourceData]
}

struct NationalData: Codable {
    let idNation: String
    let nation: String
    let idYear: Int
    let year: String
    let population: Int
    let slugNation: String

    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}

struct SourceData: Codable {
    let measures: [String]
    let annotations: Annotation
}

struct Annotation: Codable {
    let sourceName: String
    let sourceDescription: String

    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
    }
}
