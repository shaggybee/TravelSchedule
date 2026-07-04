//
//  ApiServiceBase.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 04.07.2026.
//

class ApiServiceBase {
    // MARK: - Public properties
    let client: Client
    
    // MARK: - Initializers
    init(client: Client) {
        self.client = client
    }
}
