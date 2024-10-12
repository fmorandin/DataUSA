//
//  NationDataViewModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import Combine
import os

protocol NationDataViewModelProtocol {
    func fetchData()
}

final class NationDataViewModel: NationDataViewModelProtocol {

    // MARK: - Private Variables

    private let service: NationDataServiceProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NationDataViewModel.self)
    )

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Public Variables

    @Published var nationData: [NationData] = []
    @Published var sourceData: [SourceData] = []
    @Published var errorMessage: String?

    // MARK: - Init

    init(service: NationDataServiceProtocol = NationDataService()) {

        self.service = service
    }

    // MARK: - Public Methods

    func fetchData() {

        service.fetchNationData()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .finished:
                    self?.logger.info("🌎 Nation Data received correctly")
                case .failure(let error):
                    self?.errorMessage = "❌ Error fetching data: \(error.localizedDescription)"
                    self?.logger.error("❌ Error fetching nation data: \(error)")
                }
            }, receiveValue: { [weak self] nationData in
                self?.nationData = nationData.data
                self?.sourceData = nationData.source
                self?.logger.info("🌎 Nation Data received: \(nationData.data)")
            })
            .store(in: &cancellable)
    }
}
