//
//  StationSchedule.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class StationScheduleService: StationScheduleProtocol {
    // MARK: - Private properties
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getSchedule(for station: String, at date: String? = nil) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}
