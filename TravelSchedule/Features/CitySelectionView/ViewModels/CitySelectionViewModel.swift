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
        search.isEmpty
        ? settlements
        : settlements.filter({ $0.title?.localizedCaseInsensitiveContains(search) ?? false })
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
                // TODO в следующем спринте сделать маппер для сопутствующийх типов (settlements), чтобы не расползались по проекту
                
                let stations = try await networkServiceProvider.stationsService.getAllStations()
                
                guard let countryOfRussia = stations.countries?.first(where: { $0.title == "Россия" }),
                      let regionsOfRussia = countryOfRussia.regions else {
                    return
                }
                
                settlements = regionsOfRussia
                    .flatMap { $0.settlements ?? [] }
                    .filter { settlement in
                        guard let title = settlement.title, !title.isEmpty else {
                            return false
                        }
                        
                        return !(settlement.stations ?? []).isEmpty
                    }
                    .sorted { ($0.title ?? "").localizedStandardCompare($1.title ?? "") == .orderedAscending }
                
                viewState = .loaded
            } catch let error as NetworkError {
                viewState = .error(error)
                
                throw error
            } catch {
                logger.error("[CitySelectionViewModel.fetchCities] Failed to get cities. Error - \(error)")
            }
        }
    }
}
