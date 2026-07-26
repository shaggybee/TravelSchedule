//
//  RouteSearchView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct RouteSearchView: View {
    
    let networkServiceProvider: NetworkServiceProviderProtocol
    
    @StateObject private var viewModel = RouteSearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                RoutePointSelectionView(
                    departureStationName: viewModel.departureStation?.title,
                    arrivalStationName: viewModel.arrivalStation?.title,
                    onRoutePointTypeSelected: { type in
                        navigationPath.append(RouteSearchPath.citySelection(type))
                    }
                ) {
                    viewModel.swapPoints()
                }
                
                Spacer()
            }
            .navigationDestination(for: RouteSearchPath.self) { path in
                switch path {
                case let .citySelection(type):
                    CitySelectionView(networkServiceProvider: networkServiceProvider) { city in
                        let filteredStations = viewModel.filterStations(city.stations ?? [])
                        
                        navigationPath.append(RouteSearchPath.stationSelection(type, filteredStations))
                    }
                    .toolbar(.hidden, for: .tabBar)
                case let .stationSelection(type, stations):
                    StationSelectionView(stations: stations, onStationSelected: {
                        viewModel.setSelected(station: $0, for: type)
                        
                        navigationPath.removeLast(navigationPath.count)
                    })
                    .toolbar(.hidden, for: .tabBar)
                }
            }
            .padding(EdgeInsets(
                top: AppSpacing.space24,
                leading: AppSpacing.space16,
                bottom: 0,
                trailing: AppSpacing.space16))
            .background(.ypWhite)
        }
    }
}

#Preview {
    RouteSearchView(networkServiceProvider: MockNetworkServiceProvider())
}
