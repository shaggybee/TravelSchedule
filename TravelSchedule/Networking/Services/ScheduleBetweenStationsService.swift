//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class ScheduleBetweenStationsService: ApiServiceBase, ScheduleBetweenStationsServiceProtocol {
    
    // MARK: - Private properties
    private lazy var timeFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }()
    
    private lazy var fullTimeFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter
    }()
    
    private lazy var isoFormatter = ISO8601DateFormatter()
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> [Trip] {
        do {
            let response = try await client.getScheduleBetweenStations(query: .init(
                from: from,
                to: to,
                date: date,
                transfers: true
            ))
            
            let segmentsSchedule = try response.ok.body.json
            
            return transform(segments: segmentsSchedule)
            
        } catch let clientError as ClientError {
            if let urlError = clientError.underlyingError as? URLError, urlError.code == .notConnectedToInternet {
                throw NetworkError.noInternet
            } else {
                throw NetworkError.apiError
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - Private Methods
    private func transform(segments: SegmentsSchedule) -> [Trip] {
        return (segments.segments ?? []).map { segment in
            let transfers = segment.transfers ?? []
            let thread = getThread(for: segment)
            let carrier = thread?.carrier
            let duration = getDuration(for: segment)
            
            return Trip(
                departureTime: transformTime(for: segment.departure),
                arrivalTime: transformTime(for: segment.arrival),
                hasTransfers: !transfers.isEmpty,
                duration: duration,
                carrierLogo: carrier?.logo,
                carrierCode: carrier?.code,
                carrierTitle: carrier?.title,
                transferCity: transfers.first?.title,
                startDate: getStartDate(for: segment)
            )
        }
    }
    
    private func getStartDate(for segment: Segment) -> String? {
        guard let hasTransfers = segment.has_transfers else {
            return segment.start_date
        }
        
        // Если рейс с пересадками, берем start_date у первой точки
        
        return hasTransfers
        ? segment.details?.first?.start_date
        : segment.start_date
    }
    
    private func getDuration(for segment: Segment) -> Int? {
        guard let hasTransfers = segment.has_transfers else {
            return nil
        }
        
        // Если рейс с пересадками, то суммируем продолжительность поездки по всем отрезкам
        
        return hasTransfers
        ? segment.details?.reduce(0, { result, detail in
            result + (detail.duration ?? 0)
        })
        : segment.duration
    }
    
    private func getThread(for segment: Segment) -> Thread? {
        segment.thread ?? segment.details?.first?.thread
    }
    
    // Преобразовываем время в "HH:mm"
    private func transformTime(for value: String?) -> String? {
        guard let value, !value.isEmpty else {
            return nil
        }
        
        // API возвращает время отправления/прибытия или в ISO8601 или в формате "HH:mm:ss"
        
        if let date = isoFormatter.date(from: value) {
            return timeFormatter.string(from: date)
        }
        
        if let date = fullTimeFormatter.date(from: value) {
            return timeFormatter.string(from: date)
        }
        
        return nil
    }
}
