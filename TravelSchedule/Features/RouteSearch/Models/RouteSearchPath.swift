//
//  RouteSearchPath.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

enum RouteSearchPath: Hashable {
    case citySelection(RoutePointType)
    case stationSelection(RoutePointType, [Station])
    case shedule(departureStation: Station, arrivalStation: Station)
}
