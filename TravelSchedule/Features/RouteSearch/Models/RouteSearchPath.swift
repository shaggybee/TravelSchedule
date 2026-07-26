//
//  RouteSearchPath.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

enum RouteSearchPath: Hashable {
    case citySelection(RoutePointType)
    case stationSelection(RoutePointType, [Station])
}
