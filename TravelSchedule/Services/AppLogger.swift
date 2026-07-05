//
//  AppLogger.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Logging

final class AppLogger {
    // MARK: - Static properties
    static let shared = AppLogger()
    
    // MARK: - Private properties
    private let logger = Logger(label: "")
    
    // MARK: - Initializers
    private init() {}
}

// MARK: - AppLoggerProtocol
extension AppLogger: AppLoggerProtocol {
    func error(_ message: String) {
        logger.error(Logger.Message(stringLiteral: message))
    }
    
    func info(_ message: String) {
        logger.info(Logger.Message(stringLiteral: message))
    }
}
