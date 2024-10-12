//
//  NationalDataModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

struct NationalDataModel: Codable {
    let data: [NationalData]
    let source: SourceData
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
        case idYear = "ID Year"
        case slugNation = "Slug Nation"
        case nation, year, population
    }
}

struct SourceData: Codable {
    let measures: [String]
    let annotations: Annotation
    let name: String
    let substitutions: [String]
}

struct Annotation: Codable {
    let sourceName: String
    let sourceDescription: String
    let datasetName: String
    let datasetLink: String
    let tableId: String
    let topic: String
    let subtopic: String

    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
        case datasetName = "dataset_name"
        case datasetLink = "data_link"
        case tableId = "table_id"
        case topic, subtopic
    }
}
