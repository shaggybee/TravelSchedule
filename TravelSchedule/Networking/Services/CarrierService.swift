//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class CarrierService: ApiServiceBase, CarrierServiceProtocol {
    // MARK: - Public Methods
    func getCarrierInfo(by code: Int) async throws -> CarrierInfo {
        do {
            let response = try await client.getCarrierInfo(query: .init(code: code))
            
            let carrierInfo = try response.ok.body.json
            
            return transform(carrier: carrierInfo)
        } catch {
            throw NetworkErrorMapper.map(error)
        }
    }
    
    // MARK: - Private methods
    private func transform(carrier: CarrierWrapper) -> CarrierInfo {
        CarrierInfo(
            name: carrier.carrier?.title,
            phone: carrier.carrier?.phone,
            email: carrier.carrier?.email,
            logo: carrier.carrier?.logo,
            url: carrier.carrier?.url
        )
    }
}
