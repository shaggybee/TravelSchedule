//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 01.07.2026.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    // MARK: - Private properties
    private var logger = AppLogger.shared
    private var networkServiceProvider: NetworkServiceProviderProtocol?
    
    init() {
        do {
            networkServiceProvider = try AppAssembly().makeNetworkServiceProvider()
        } catch {
            logger.error("[TravelScheduleApp] Failed create network service")
        }
        
        configTabBar()
    }
    
    var body: some Scene {
        WindowGroup {
            if let networkServiceProvider {
                MainView(networkServiceProvider: networkServiceProvider)
            } else {
                ErrorStateView(error: .apiError)
            }
        }
    }
    
    private func configTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .black.withAlphaComponent(0.3)
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
