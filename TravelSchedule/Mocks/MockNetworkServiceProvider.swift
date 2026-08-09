//
//  MockNetworkServiceProvider.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

final class MockNetworkServiceProvider: NetworkServiceProviderProtocol {
    // MARK: - Public properties
    private(set) lazy var stationsService: StationsServiceProtocol = MockStationsService()
    private(set) lazy var scheduleService: ScheduleBetweenStationsServiceProtocol = MockScheduleBetweenStationsService()
    private(set) lazy var carrierService: CarrierServiceProtocol = MockCarrierService()
}
