//
//  RouteStationsServiceProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

protocol RouteStationsServiceProtocol {
    func getRouteStations(for uid: String, at date: String?) async throws -> RouteStations
}
