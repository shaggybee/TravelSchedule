//
//  NetworkErrorMapper.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 19.08.2026.
//

import Foundation
import OpenAPIRuntime

enum NetworkErrorMapper {
    static func map(_ error: Error) -> NetworkError {
        guard let error = error as? ClientError, let urlError = error.underlyingError as? URLError else {
            return .apiError
        }
        
        switch urlError.code {
        case .dataNotAllowed,
                .notConnectedToInternet,
                .networkConnectionLost,
                .cannotFindHost,
                .cannotConnectToHost,
                .timedOut:
            return .noInternet
        default:
            return .apiError
        }
    }
}
