//
//  PopulationDataModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

struct PopulationDataModel: Decodable, Hashable {

    let data: [PopulationData]
    let source: [SourceData]
}

struct PopulationData: Decodable, Hashable {

    let idLocation: String
    let location: String
    let idYear: Int
    let year: String
    let population: Int

    var id: Self { self }

    // Custom keys to handle different field names ("Nation" vs "State")
    enum CodingKeys: String, CodingKey {
        case idLocation = "ID Nation"
        case idLocationState = "ID State"
        case location = "Nation"
        case locationState = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
    }

    // Custom initializer to decode conditionally
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode for both Nation and State, using conditional decoding
        idLocation = try container.decodeIfPresent(String.self, forKey: .idLocation) ?? container.decode(String.self, forKey: .idLocationState)
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? container.decode(String.self, forKey: .locationState)
        idYear = try container.decode(Int.self, forKey: .idYear)
        year = try container.decode(String.self, forKey: .year)
        population = try container.decode(Int.self, forKey: .population)
    }
}

struct SourceData: Decodable, Hashable {

    let measures: [String]
    let annotations: Annotation
}

struct Annotation: Decodable, Hashable {

    let sourceName: String
    let sourceDescription: String

    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
    }
}
