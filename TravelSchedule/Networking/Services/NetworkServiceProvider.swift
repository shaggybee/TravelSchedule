//
//  NetworkServiceProvider.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

final class NetworkServiceProvider: NetworkServiceProviderProtocol {
    // MARK: - Private properties
    private let client: Client
    
    private lazy var stationsService: StationsServiceProtocol = StationsService(client: client)
    private lazy var scheduleService: ScheduleBetweenStationsServiceProtocol = ScheduleBetweenStationsService(client: client)
    private lazy var carrierService: CarrierServiceProtocol = CarrierService(client: client)

    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public methods
    func getAllStations() async throws -> [Settlement] {
        try await stationsService.getAllStations()
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> [Trip] {
        try await scheduleService.getScheduleBetweenStations(
            from: from,
            to: to,
            date: date)
    }
    
    func getCarrierInfo(by code: Int) async throws -> CarrierInfo {
       try await carrierService.getCarrierInfo(by: code)
    }
}
