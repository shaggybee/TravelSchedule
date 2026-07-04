//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class CopyrightService: CopyrightServiceProtocol {
    // MARK: - Private properties
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getCopyright() async throws -> CopyrightWrapper {
        let response = try await client.getCopyright()
        
        return try response.ok.body.json
    }
}

