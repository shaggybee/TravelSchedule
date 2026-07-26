//
//  RouteSearchViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation
import Combine

final class RouteSearchViewModel: ObservableObject {
    
    @Published var departureStation: Station?
    @Published var arrivalStation: Station?
    
    func setSelected(station: Station, for type: RoutePointType) {
        switch type {
        case .departure:
            departureStation = station
        default:
            arrivalStation = station
        }
    }
    
    func swapPoints() {
        if departureStation == nil && arrivalStation == nil { return }
            
        let temp = departureStation
        
        departureStation = arrivalStation
        arrivalStation = temp
    }
    
    func filterStations(_ stations: [Station]) -> [Station] {
        stations.filter {
            $0.transport_type == TransportType.train.rawValue &&
            ($0.station_type == StationType.trainStation.rawValue || $0.station_type == StationType.station.rawValue )
        }
    }
}
