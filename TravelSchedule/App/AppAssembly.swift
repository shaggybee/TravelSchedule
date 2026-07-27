//
//  AppAssembly.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class AppAssembly {
    // MARK: Public methods
    func makeNetworkServiceProvider() throws -> NetworkServiceProviderProtocol {
        let serverUrl = try Servers.Server1.url()
        
        let client = Client(
            serverURL: serverUrl,
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(apiKey: NetworkingConstants.apiKey)])
        
        return NetworkServiceProvider(client: client)
    }
}
