//
//  ScheduleFiltersViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import Foundation
import Combine

final class ScheduleFiltersViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var filters: ScheduleFilters
    
    var isApplyAvailable: Bool {
        filters.showWithTransfers != nil || !filters.departureTimes.isEmpty
    }
    
    init(filters: ScheduleFilters) {
        self.filters = filters
    }
    
    // MARK: - Public methods
    func toggle(_ departureTime: DepartureTime) {
        if isSelected(departureTime) {
            filters.departureTimes.remove(departureTime)
        } else {
            filters.departureTimes.insert(departureTime)
        }
    }
    
    func isSelected(_ time: DepartureTime) -> Bool {
        filters.departureTimes.contains(time)
    }
}
