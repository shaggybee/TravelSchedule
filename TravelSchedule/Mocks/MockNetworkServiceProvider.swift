//
//  MockNetworkServiceProvider.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

final class MockNetworkServiceProvider: NetworkServiceProviderProtocol {
    // MARK: - Private properties
    private lazy var stationsService: StationsServiceProtocol = MockStationsService()
    private lazy var scheduleService: ScheduleBetweenStationsServiceProtocol = MockScheduleBetweenStationsService()
    private lazy var carrierService: CarrierServiceProtocol = MockCarrierService()
    
    // MARK: - Public methods
    func getAllStations() async throws -> [Settlement] {
        try await stationsService.getAllStations()
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> [Trip] {
        try await scheduleService.getScheduleBetweenStations(
            from: from,
            to: to,
            date: date)
    }
    
    func getCarrierInfo(by code: Int) async throws -> CarrierInfo {
       try await carrierService.getCarrierInfo(by: code)
    }
}
