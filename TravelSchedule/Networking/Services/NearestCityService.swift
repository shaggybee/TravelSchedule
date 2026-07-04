//
//  NearestCityService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class NearestCityService: ApiServiceBase, NearestCityServiceProtocol {
    // MARK: - Public Methods
    func getNearestCity(lat: Double, lng: Double, distance: Int? = nil) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        
        return try response.ok.body.json
    }
}
