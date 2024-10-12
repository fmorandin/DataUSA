//
//  NationalDataService.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import Combine
import os

protocol NationalDataServiceProtocol {
    func fetchNationalData() -> AnyPublisher<NationalData, Error>
}

struct NationalDataService: NationalDataServiceProtocol {

    // MARK: - Private Variables

    private var networkManager: NetworkManagerProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NationalDataService.self)
    )

    // MARK: - Init

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {

        self.networkManager = networkManager
    }

    // MARK: - Public Methods

    func fetchNationalData() -> AnyPublisher<NationalData, Error> {

        logger.notice("🛜 Starting to fetch the national data.")

        return networkManager.getData(for: Endpoints.national.rawValue, responseModel: NationalData.self)
    }
}
