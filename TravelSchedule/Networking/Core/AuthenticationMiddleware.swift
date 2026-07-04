//
//  AuthenticationMiddleware.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Foundation
import OpenAPIRuntime
import HTTPTypes

struct AuthenticationMiddleware {
    private let apiKey: String
    
    init(apiKey: String) {
         self.apiKey = apiKey
     }
}

extension AuthenticationMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPTypes.HTTPRequest,
        body: OpenAPIRuntime.HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPTypes.HTTPRequest, OpenAPIRuntime.HTTPBody?, URL) async throws -> (HTTPTypes.HTTPResponse, OpenAPIRuntime.HTTPBody?)
    ) async throws -> (HTTPTypes.HTTPResponse, OpenAPIRuntime.HTTPBody?) {
        var request = request
        
        request.headerFields[.authorization] = apiKey
        
        return try await next(request, body, baseURL)
    }
}
