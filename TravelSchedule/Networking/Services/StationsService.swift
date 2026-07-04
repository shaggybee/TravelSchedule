//
//  StationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class StationsService: StationsServiceProtocol {
    // MARK: - Private properties
    private let client: Client
    private lazy var decoder = JSONDecoder()
    
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init())
        
        let responseBodyHtml = try response.ok.body.html
        let limit = 50 * 1024 * 1024
        let fullData = try await Data(collecting: responseBodyHtml, upTo: limit)
        
        return try decoder.decode(AllStations.self, from: fullData)
    }
}
