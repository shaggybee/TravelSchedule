//
//  ContactLinkType.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 05.08.2026.
//

import Foundation

enum ContactLinkScheme: String {
    case phone = "tel"
    case email = "mailto"
    case web = "web"
    
    var description: String {
        switch self {
        case .email: "E-mail"
        case .phone: "Телефон"
        case .web: "Веб-сайт"
        }
    }
    
    func url(for value: String) -> URL? {
        switch self {
        case .phone, .email:
            URL(string: "\(rawValue):\(value)")
        case .web:
            URL(string: value)
        }
    }
}
