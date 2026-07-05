//
//  RouteStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class RouteStationsService: ApiServiceBase, RouteStationsServiceProtocol {
    // MARK: - Public Methods
    func getRouteStations(for uid: String, at date: String? = nil) async throws -> RouteStations {
        let response = try await client.getRouteStations(query: .init(
            uid: uid,
            date: date
        ))
        
        return try response.ok.body.json
    }
}
