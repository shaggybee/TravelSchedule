//
//  MainView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 24.07.2026.
//

import SwiftUI

struct MainView: View {
    let networkServiceProvider: NetworkServiceProviderProtocol
    
    var body: some View {
        TabView {
            RouteSearchView(networkServiceProvider: networkServiceProvider)
                .tabItem {
                    Image(.arrowUpMessage)
                }
            
            SettingsView()
                .tabItem {
                    Image(.settings)
                }
        }
        .tint(.ypBlack)
        .background(.ypWhite)
    }
}

#Preview {
    MainView(networkServiceProvider: MockNetworkServiceProvider())
}
