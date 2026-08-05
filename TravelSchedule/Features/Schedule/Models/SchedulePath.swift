//
//  SchedulePath.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import Foundation

enum SchedulePath: Hashable {
    case scheduleFilters
    case carrier(code: Int?)
}
