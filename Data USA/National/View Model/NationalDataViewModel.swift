//
//  NationalDataViewModel.swift
//  Data USA
//
//  Created by Felipe Morandin on 12/10/2024.
//

import Foundation
import Combine
import os

protocol NationalDataViewModelProtocol {
    func fetchData()
}

final class NationalDataViewModel: NationalDataViewModelProtocol {

    // MARK: - Private Variables

    private let service: NationalDataServiceProtocol

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: NationalDataViewModel.self)
    )

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Public Variables

    @Published var nationalData: [NationalData] = []
    @Published var errorMessage: String?

    // MARK: - Init

    init(service: NationalDataServiceProtocol = NationalDataService()) {

        self.service = service
    }

    // MARK: - Public Methods

    func fetchData() {

        service.fetchNationalData()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .finished:
                    self?.logger.info("National Data received correctly")
                case .failure(let error):
                    self?.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    self?.logger.error("Error fetching national data: \(error)")
                }
            }, receiveValue: { nationalData in
                self.nationalData = nationalData.data
            })
            .store(in: &cancellable)
    }
}
