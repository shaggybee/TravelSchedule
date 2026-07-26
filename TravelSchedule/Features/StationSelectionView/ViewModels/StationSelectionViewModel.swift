//
//  StationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation
import Combine

final class StationSelectionViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var search = ""
    
    var isStationsEmpty: Bool {
        filteredStations.isEmpty
    }
    
    var filteredStations: [Station] {
        if search.isEmpty {
            return stations
        }
        
        return stations.filter({ $0.title?.localizedCaseInsensitiveContains(search) ?? false })
    }
    
    // MARK: - Private properties
    private let stations: [Station]
    
    init(stations: [Station] = []) {
        self.stations = stations
    }
}

