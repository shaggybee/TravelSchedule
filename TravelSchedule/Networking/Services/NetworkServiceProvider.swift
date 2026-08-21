//
//  NetworkServiceProvider.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

actor NetworkServiceProvider: NetworkServiceProviderProtocol {
    // MARK: - Private properties
    private let client: Client
    
    private let stationsService: StationsServiceProtocol
    private let scheduleService: ScheduleBetweenStationsServiceProtocol
    private let carrierService: CarrierServiceProtocol
    
    private var cashedSettlements: [Settlement]?
    private var cashedCarriers: [Int: CarrierInfo] = [:]
    
    init(client: Client) {
        self.client = client
        self.stationsService = StationsService(client: client)
        self.scheduleService = ScheduleBetweenStationsService(client: client)
        self.carrierService = CarrierService(client: client)
    }
    
    // MARK: - Public methods
    func getAllStations() async throws -> [Settlement] {
        if let cashedSettlements {
            return cashedSettlements
        }
        
        let settlements = try await stationsService.getAllStations()
        
        cashedSettlements = settlements
        
        return settlements
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> [Trip] {
        try await scheduleService.getScheduleBetweenStations(
            from: from,
            to: to,
            date: date)
    }
    
    func getCarrierInfo(by code: Int) async throws -> CarrierInfo {
        if let carrier = cashedCarriers[code] {
            return carrier
        }
        
        let carrierInfo = try await carrierService.getCarrierInfo(by: code)
        
        cashedCarriers[code] = carrierInfo
        
        return carrierInfo
    }
}
