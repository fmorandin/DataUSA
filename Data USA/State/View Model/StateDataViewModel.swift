//
//  StateDataViewModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os

protocol StateDataViewModelProtocol {
    func fetchData() async
}

final class StateDataViewModel: StateDataViewModelProtocol, ObservableObject {

    // MARK: - Private Variables

    private let service: StateDataServiceProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: StateDataViewModel.self)
    )

    // MARK: - Public Variables

    @Published var stateData: [StateData] = []
    @Published var sourceData: [SourceData] = []
    @Published var errorMessage: String?

    // MARK: - Init

    init(service: StateDataServiceProtocol = StateDataService()) {

        self.service = service
    }

    // MARK: - Public Methods

    func fetchData() async {
        
        do {
            let data = try await service.fetchStatesData()
            await MainActor.run {
                self.stateData = data.data
                self.sourceData = data.source
                self.logger.info("📍 State Data received: \(data.data)")
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "❌ Error fetching data: \(error.localizedDescription)"
                self.logger.error("❌ Error fetching state data: \(error)")
            }
        }
    }
}
