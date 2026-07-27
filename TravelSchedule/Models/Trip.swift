//
//  Trip.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import Foundation

struct Trip {
    let uid: UUID = UUID()
    let departureTime: String?
    let arrivalTime: String?
    let hasTransfers: Bool
    let duration: Int?
    let carrierLogo: String?
    let carrierCode: Int?
    let carrierTitle: String?
    let transferCity: String?
    let startDate: String?
}
