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

@MainActor
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
        : settlements.filter({ $0.title.localizedCaseInsensitiveContains(search) })
    }
    
    var settlements: [Settlement] = []
    
    // MARK: - Private properties
    private var networkServiceProvider: NetworkServiceProviderProtocol
    private var logger = AppLogger.shared
    
    init(networkServiceProvider: NetworkServiceProviderProtocol) {
        self.networkServiceProvider = networkServiceProvider
    }
    
    // MARK: - Public methods
    func fetchCities() async {
        guard viewState != .loaded else { return }
        
        viewState = .loading
        
        do {
            settlements = try await networkServiceProvider.getAllStations()
            
            viewState = .loaded
        } catch {
            if let error = error as? NetworkError {
                viewState = .error(error)
            } else {
                viewState = .error(.apiError)
            }
            
            logger.error("[CitySelectionViewModel.fetchCities] Failed to get cities. Error - \(error)")
        }
    }
}
