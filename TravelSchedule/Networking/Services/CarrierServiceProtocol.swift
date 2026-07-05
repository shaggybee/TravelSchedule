//
//  CarrierServiceProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

protocol CarrierServiceProtocol {
    func getCarrierInfo(by code: Int) async throws -> CarrierWrapper
}
