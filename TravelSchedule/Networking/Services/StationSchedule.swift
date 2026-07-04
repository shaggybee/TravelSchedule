//
//  StationSchedule.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class StationScheduleService: ApiServiceBase, StationScheduleProtocol {
    // MARK: - Public Methods
    func getSchedule(for station: String, at date: String? = nil) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}
