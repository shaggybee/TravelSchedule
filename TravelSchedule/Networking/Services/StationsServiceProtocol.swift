//
//  StationsServiceProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

protocol StationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}
