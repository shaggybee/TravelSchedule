//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class ScheduleBetweenStationsService: ApiServiceBase, ScheduleBetweenStationsServiceProtocol {
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> SegmentsSchedule {
        let response = try await client.getScheduleBetweenStations(query: .init(
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}
