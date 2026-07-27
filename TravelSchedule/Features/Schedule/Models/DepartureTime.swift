//
//  DepartureTime.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import Foundation

enum DepartureTime: String, CaseIterable, Hashable {
    case morning
    case afternoon
    case evening
    case night
    
    var title: String {
        switch self {
        case .morning:
            "Утро 06:00 – 12:00"
        case .afternoon:
            "День 12:00 – 18:00"
        case .evening:
            "Вечер 18:00 – 00:00"
        case .night:
            "Ночь 00:00 – 06:00"
        }
    }
    
    func contains(hour: Int) -> Bool {
        switch self {
        case .morning:  return 6..<12 ~= hour
        case .afternoon:return 12..<18 ~= hour
        case .evening:  return 18..<24 ~= hour
        case .night:    return 0..<6 ~= hour
        }
    }
}
