//
//  NetworkServiceProviderProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

protocol NetworkServiceProviderProtocol {
    var stationsService: StationsServiceProtocol { get }
    var scheduleService: ScheduleBetweenStationsServiceProtocol { get }
    var carrierService: CarrierServiceProtocol { get }
}
