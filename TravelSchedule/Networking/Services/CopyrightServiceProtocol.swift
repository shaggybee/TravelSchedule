//
//  CopyrightServiceProtocol.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightWrapper
}
