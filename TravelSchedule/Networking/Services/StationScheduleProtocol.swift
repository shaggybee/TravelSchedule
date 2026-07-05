//
//  StationScheduleProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

protocol StationScheduleProtocol {
    func getSchedule(for station: String, at date: String?) async throws -> StationSchedule
}
