//
//  MockNetworkServiceProvider.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

final class MockNetworkServiceProvider: NetworkServiceProviderProtocol {
    private(set) lazy var stationsService: StationsServiceProtocol = MockStationsService()
}
