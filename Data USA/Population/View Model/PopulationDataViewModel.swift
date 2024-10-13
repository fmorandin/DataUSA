//
//  PopulationDataViewModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os

protocol PopulationDataViewModelProtocol {
    func fetchData(scope: ScopeOptions, timeInterval: TimeIntervalOptions?) async
}

final class PopulationDataViewModel: PopulationDataViewModelProtocol, ObservableObject {

    // MARK: - Private Variables

    private let service: PopulationDataServiceProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: PopulationDataViewModel.self)
    )

    // MARK: - Public Variables

    @Published var populationData: [PopulationData] = []
    @Published var sourceData: [SourceData] = []
    @Published var errorMessage: String?

    var scope: ScopeOptions = .nation
    var timeInterval: TimeIntervalOptions?

    // MARK: - Init

    init(service: PopulationDataServiceProtocol = PopulationDataService()) {

        self.service = service
    }

    // MARK: - Public Methods

    func fetchData(scope: ScopeOptions, timeInterval: TimeIntervalOptions?) async {

        do {
            let data = try await service.fetchPopulationData(scope: scope, timeInterval: timeInterval)
            await MainActor.run {
                self.populationData = data.data
                self.sourceData = data.source
                self.logger.info("🌎 Nation Data received: \(data.data)")
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "❌ Error fetching data: \(error.localizedDescription)"
                self.logger.error("❌ Error fetching nation data: \(error)")
            }
        }
    }
}
