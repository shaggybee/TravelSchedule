//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    // MARK: - Private properties
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> Segments {
        let response = try await client.getScheduleBetweenStations(query: .init(
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}
