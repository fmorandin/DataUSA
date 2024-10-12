//
//  StateDataService.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os

protocol StateDataServiceProtocol {
    func fetchStateData() async throws -> StateDataModel
}

struct StateDataService: StateDataServiceProtocol {

    // MARK: - Private Variables

    private var networkManager: NetworkManagerProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: StateDataService.self)
    )

    // MARK: - Init

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {

        self.networkManager = networkManager
    }

    // MARK: - Public Methods

    func fetchStateData() async throws -> StateDataModel {

        logger.notice("🛜 Starting to fetch the state data.")

        return try await networkManager.getData(for: Endpoints.state.rawValue, responseModel: StateDataModel.self)
    }
}
