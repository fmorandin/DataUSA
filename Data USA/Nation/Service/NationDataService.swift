//
//  NationDataService.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import Combine
import os

protocol NationDataServiceProtocol {
    func fetchNationData() -> AnyPublisher<NationDataModel, Error>
}

struct NationDataService: NationDataServiceProtocol {

    // MARK: - Private Variables

    private var networkManager: NetworkManagerProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NationDataService.self)
    )

    // MARK: - Init

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {

        self.networkManager = networkManager
    }

    // MARK: - Public Methods

    func fetchNationData() -> AnyPublisher<NationDataModel, Error> {

        logger.notice("🛜 Starting to fetch the nation data.")

        return networkManager.getData(for: Endpoints.nation.rawValue, responseModel: NationDataModel.self)
    }
}
