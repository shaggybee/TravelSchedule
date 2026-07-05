//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class CarrierService: ApiServiceBase, CarrierServiceProtocol {
    // MARK: - Public Methods
    func getCarrierInfo(by code: Int) async throws -> CarrierWrapper {
        let response = try await client.getCarrierInfo(query: .init(code: code))
  
        return try response.ok.body.json
    }
}
