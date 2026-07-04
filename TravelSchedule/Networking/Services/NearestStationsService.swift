//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class NearestStationsService: NearestStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        
        return try response.ok.body.json
    }
}
