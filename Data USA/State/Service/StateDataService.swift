//
//  StateDataService.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import Combine
import os

protocol StateDataServiceProtocol {
    func fetchStatesData() -> AnyPublisher<StateDataModel, Error>
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

    func fetchStatesData() -> AnyPublisher<StateDataModel, Error> {

        logger.notice("🛜 Starting to fetch the state data.")

        return networkManager.getData(for: Endpoints.state.rawValue, responseModel: StateDataModel.self)
    }
}
