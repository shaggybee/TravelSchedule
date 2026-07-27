//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import Foundation
import Combine

final class ScheduleViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var viewState: ViewState = .idle
    @Published var filteredTrips: [Trip] = []
    
    var routeTitle: String {
        "\(departureStation.title ?? "") → \(arrivalStation.title ?? "")"
    }
    
    var hasActiveFilters: Bool {
        !scheduleFilters.departureTimes.isEmpty || scheduleFilters.showWithTransfers != nil
    }
    
    private(set) var scheduleFilters: ScheduleFilters = ScheduleFilters()
    
    // MARK: - Private properties
    private var networkServiceProvider: NetworkServiceProviderProtocol
    private var logger = AppLogger.shared
    private lazy var dateFormatter = DateFormatter()
    
    private var departureStation: Station
    private var arrivalStation: Station
    
    private var trips: [Trip] = []
    
    init(
        departureStation: Station,
        arrivalStation: Station,
        networkServiceProvider: NetworkServiceProviderProtocol
    ) {
        self.networkServiceProvider = networkServiceProvider
        self.departureStation = departureStation
        self.arrivalStation = arrivalStation
    }
    
    // MARK: - Public methods
    func setFilters(_ filters: ScheduleFilters) {
        scheduleFilters = filters
        
        filteredTrips = filter(trips: trips)
    }
    
    func fetchSchedule() {
        viewState = .loading
        
        Task {
            do {
                guard let departureStationCode = departureStation.codes?.yandex_code,
                      let arrivalStationCode = arrivalStation.codes?.yandex_code else
                {
                    viewState = .loaded
                    
                    return
                }
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let currentDate = Date()
                
                trips = try await networkServiceProvider.scheduleService.getScheduleBetweenStations(
                    from: departureStationCode,
                    to: arrivalStationCode,
                    date: dateFormatter.string(from: currentDate)
                )
                
                filteredTrips = filter(trips: trips)
                
                viewState = .loaded
            } catch let error as NetworkError {
                viewState = .error(error)
                
                throw error
            } catch {
                logger.error("[ScheduleViewModel.fetchSchedule] Failed to get schedule. Error - \(error)")
            }
            
        }
    }
    
    // MARK: - Private methods
    private func filter(trips: [Trip]) -> [Trip] {
        if (!hasActiveFilters) {
            return trips
        }
        
        return trips.filter {
            matchesWithTransfers($0) && matchesDepartureTime($0)
        }
    }
    
    private func matchesDepartureTime(_ trip: Trip) -> Bool {
        if scheduleFilters.departureTimes.isEmpty {
            return true
        }
        
        guard let departureTime = trip.departureTime, let hour = Int(departureTime.prefix(2)) else {
            return true
        }
        
        return scheduleFilters.departureTimes.contains {
            $0.contains(hour: hour)
        }
    }
    
    private func matchesWithTransfers(_ trip: Trip) -> Bool {
        guard let showWithTransfers = scheduleFilters.showWithTransfers else {
            return true
        }
        
        return showWithTransfers || !trip.hasTransfers
    }
}
