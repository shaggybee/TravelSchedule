//
//  ViewState.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case loaded
    case error(NetworkError)
}
