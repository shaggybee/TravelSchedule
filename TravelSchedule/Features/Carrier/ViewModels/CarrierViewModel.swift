//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 05.08.2026.
//

import Foundation
import Combine

@MainActor
final class CarrierViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var viewState: ViewState = .idle
    
    var carrierInfo: CarrierInfo?
    
    var hasCarrierInfo: Bool {
        carrierInfo != nil
    }
    
    // MARK: - Private properties
    private var networkServiceProvider: NetworkServiceProviderProtocol
    private var logger = AppLogger.shared
    
    private let carrierCode: Int?
    
    init(
        carrierCode: Int?,
        networkServiceProvider: NetworkServiceProviderProtocol
    ) {
        self.networkServiceProvider = networkServiceProvider
        self.carrierCode = carrierCode
    }
    
    // MARK: - Public methods
    func fetchCarrierInfo() async {
        guard viewState != .loaded else { return }
        
        viewState = .loading
        
        do {
            guard let carrierCode else {
                viewState = .loaded
                
                return
            }
            
            carrierInfo = try await networkServiceProvider.getCarrierInfo(by: carrierCode)
            
            viewState = .loaded
        } catch {
            if let error = error as? NetworkError {
                viewState = .error(error)
            } else {
                viewState = .error(.apiError)
            }
            
            logger.error("[CarrierViewModel.fetchCarrierInfo] Failed to get carrier info. Error - \(error)")
        }
    }
}
