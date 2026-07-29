//
//  NetworkServiceProvider.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

final class NetworkServiceProvider: NetworkServiceProviderProtocol {
    private let client: Client
    
    private(set) lazy var stationsService: StationsServiceProtocol = StationsService(client: client)
    private(set) lazy var scheduleService: ScheduleBetweenStationsServiceProtocol = ScheduleBetweenStationsService(client: client)

    init(client: Client) {
        self.client = client
    }
}
