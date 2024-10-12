//
//  Endpoints.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation

enum Endpoints: String {

    case nation = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
    case state = "https://datausa.io/api/data?drilldowns=State&measures=Population&year=latest"
}
