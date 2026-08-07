//
//  RouteSearchViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation
import Combine

final class RouteSearchViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var departureStation: Station?
    @Published var arrivalStation: Station?
    @Published var stories: [Story] = Story.mockStoriesList
    
    var isSearchScheduleAvailable: Bool {
        departureStation != nil && arrivalStation != nil
    }
    
    // MARK: - Public methods
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
}
