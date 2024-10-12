//
//  NationDataViewModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import os

protocol NationDataViewModelProtocol {
    func fetchData() async
}

final class NationDataViewModel: NationDataViewModelProtocol, ObservableObject {

    // MARK: - Private Variables

    private let service: NationDataServiceProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NationDataViewModel.self)
    )

    // MARK: - Public Variables

    @Published var nationData: [NationData] = []
    @Published var sourceData: [SourceData] = []
    @Published var errorMessage: String?

    // MARK: - Init

    init(service: NationDataServiceProtocol = NationDataService()) {

        self.service = service
    }

    // MARK: - Public Methods

    func fetchData() async {

        do {
            let data = try await service.fetchNationData()
            await MainActor.run {
                self.nationData = data.data
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
