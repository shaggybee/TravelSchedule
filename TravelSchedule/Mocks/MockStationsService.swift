//
//  MockStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

final class MockStationsService: StationsServiceProtocol {
    // MARK: - Public Methods
    func getAllStations() async throws -> AllStations {
        return AllStations(countries: [])
    }
}
