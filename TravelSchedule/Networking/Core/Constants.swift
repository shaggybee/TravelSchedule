//
//  Constants.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Foundation

enum NetworkingConstants {
    private static let apiInfoPlistKey = "YANDEX_API_KEY"
    
    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: apiInfoPlistKey) as? String,
                !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            preconditionFailure("Missing api key")
        }
        
        return apiKey
    }
}
