//
//  NetworkServiceProviderProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

protocol NetworkServiceProviderProtocol:
    StationsServiceProtocol,
    ScheduleBetweenStationsServiceProtocol,
    CarrierServiceProtocol {}
