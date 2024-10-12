//
//  StateDataViewModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import Combine
import os

protocol StateDataViewModelProtocol {
    func fetchData()
}

final class StateDataViewModel: StateDataViewModelProtocol {

    // MARK: - Private Variables

    private let service: StateDataServiceProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: StateDataViewModel.self)
    )

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Public Variables

    @Published var stateData: [StateData] = []
    @Published var sourceData: [SourceData] = []
    @Published var errorMessage: String?

    // MARK: - Init

    init(service: StateDataServiceProtocol = StateDataService()) {

        self.service = service
    }

    // MARK: - Public Methods

    func fetchData() {

        service.fetchStatesData()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.logger.info("State Data received correctly")
                case .failure(let error):
                    self?.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    self?.logger.error("Error fetching state data: \(error)")
                }
            }, receiveValue: { [weak self] stateData in
                self?.stateData = stateData.data
                self?.sourceData = stateData.source
                self?.logger.info("State Data received: \(stateData.data)")
            })
            .store(in: &cancellable)
    }
}
