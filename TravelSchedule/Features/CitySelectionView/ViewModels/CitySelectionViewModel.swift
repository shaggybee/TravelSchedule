//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation
import Combine
import OpenAPIRuntime
import OpenAPIURLSession

final class CitySelectionViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var viewState: ViewState = .idle
    
    @Published var search = ""
    
    var isSettlementsEmpty: Bool {
        filteredSettlements.isEmpty
    }
    
    var filteredSettlements: [Settlement] {
        if search.isEmpty {
            return settlements
        }
        
        return settlements.filter({ $0.title?.localizedCaseInsensitiveContains(search) ?? false })
    }
    
    var settlements: [Settlement] = []
    
    // MARK: - Private properties
    private var networkServiceProvider: NetworkServiceProviderProtocol
    private var logger = AppLogger.shared
    
    init(networkServiceProvider: NetworkServiceProviderProtocol) {
        self.networkServiceProvider = networkServiceProvider
    }
    
    // MARK: - Public methods
    func fetchCities() {
        viewState = .loading
    
        Task {
            do {
                let stations = try await networkServiceProvider.stationsService.getAllStations()
                
                guard let countryOfRussia = stations.countries?.first(where: { $0.title == "Россия" }),
                      let regionsOfRussia = countryOfRussia.regions else {
                    return
                }
                
                settlements = regionsOfRussia
                    .flatMap { $0.settlements ?? [] }
                
                viewState = .loaded
            } catch {
                if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    viewState = .error(NetworkError.noInternet)
                } else {
                    viewState = .error(NetworkError.apiError)
                }
                
                logger.error("[CitySelectionViewModel.fetchCities] Failed to get cities. Error - \(error)")
            }
        }
    }
}
