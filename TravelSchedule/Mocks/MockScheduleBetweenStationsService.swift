//
//  MockScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

final class MockScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> [Trip] {
        []
    }
}
