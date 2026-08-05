//
//  MockCarrierService.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 05.08.2026.
//

final class MockCarrierService: CarrierServiceProtocol {
    func getCarrierInfo(by code: Int) async throws -> CarrierInfo {
        CarrierInfo(
            name: "РЖД/ФПК",
            phone: "+7 (800) 775-00-00",
            email: "info@rzd.ru",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            url: "http://www.rzd.ru/"
        )
    }
}
