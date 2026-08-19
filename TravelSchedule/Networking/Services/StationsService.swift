//
//  StationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class StationsService: ApiServiceBase, StationsServiceProtocol {
    // MARK: - Private properties
    private lazy var decoder = JSONDecoder()
    
    // MARK: - Public methods
    func getAllStations() async throws -> [Settlement] {
        do {
            let response = try await client.getAllStations(query: .init())
            
            let responseBodyHtml = try response.ok.body.html
            let limit = 50 * 1024 * 1024
            let fullData = try await Data(collecting: responseBodyHtml, upTo: limit)
            
            let allStations = try decoder.decode(AllStations.self, from: fullData)
            
            return transform(stations: allStations)
        } catch {
            throw NetworkErrorMapper.map(error)
        }
    }
    
    // MARK: - Private methods
    private func transform(stations: AllStations) -> [Settlement] {
        guard let countryOfRussia = stations.countries?.first(where: { $0.title == "Россия" }),
              let regionsOfRussia = countryOfRussia.regions else {
            return []
        }
        
        let settlements = regionsOfRussia
            .flatMap { transform(settlements: $0.settlements) }
            .filter { settlement in
                guard !settlement.title.isEmpty else {
                    return false
                }
                
                return !settlement.stations.isEmpty
            }
            .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
        
        return settlements
    }
    
    private func transform(settlements: [SettlementDTO]?) -> [Settlement] {
        let preparedSettlements: [Settlement] = settlements?.map { settlement in
            let stations = settlement.stations?.map {
                Station(
                    title: $0.title ?? "",
                    code: $0.codes?.yandex_code
                )
            } ?? []
            
            return Settlement(
                title: settlement.title ?? "",
                stations: stations
            )
        } ?? []
        
        
        return preparedSettlements
    }
}
