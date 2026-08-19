//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 06.08.2026.
//

import Foundation
import Observation

@Observable
final class SettingsViewModel {
    // MARK: - Public properties
    var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.1"
    }
}
