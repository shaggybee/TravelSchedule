//
//  ScheduleFilters.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import Foundation

struct ScheduleFilters {
    var departureTimes: Set<DepartureTime> = []
    var showWithTransfers: Bool?
}
