//
//  Settlement.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 19.08.2026.
//

struct Settlement: Hashable, Sendable {
    let title: String
    let stations: [Station]
}
