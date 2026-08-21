//
//  StationsServiceProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

protocol StationsServiceProtocol: Sendable {
    func getAllStations() async throws -> [Settlement]
}
