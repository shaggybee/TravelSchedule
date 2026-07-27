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
            VStack(spacing: AppSpacing.space16) {
                RoutePointSelectionView(
                    departureStationName: viewModel.departureStation?.title,
                    arrivalStationName: viewModel.arrivalStation?.title,
                    onRoutePointTypeSelected: { type in
                        navigationPath.append(RouteSearchPath.citySelection(type))
                    }
                ) {
                    viewModel.swapPoints()
                }
                
                if viewModel.isSearchScheduleAvailable{
                    searchButton
                }
                
                Spacer()
            }
            .navigationDestination(for: RouteSearchPath.self) { path in
                switch path {
                case let .citySelection(type):
                    let citySelectionViewModel = CitySelectionViewModel(networkServiceProvider: networkServiceProvider)
                    
                    CitySelectionView(viewModel: citySelectionViewModel) { city in
                        navigationPath.append(RouteSearchPath.stationSelection(type, city.stations ?? []))
                    }
                    .toolbar(.hidden, for: .tabBar)
                    .navigationTitle("Выбор города")
                case let .stationSelection(type, stations):
                    StationSelectionView(stations: stations, onStationSelected: {
                        viewModel.setSelected(station: $0, for: type)
                        
                        navigationPath = NavigationPath()
                    })
                    .toolbar(.hidden, for: .tabBar)
                    .navigationTitle("Выбор станции")
                case let .shedule(departureStation, arrivalStation):
                    let scheduleViewModel = ScheduleViewModel(
                        departureStation: departureStation,
                        arrivalStation: arrivalStation,
                        networkServiceProvider: networkServiceProvider
                    )
                    
                    ScheduleView(
                        viewModel: scheduleViewModel,
                        navigationPath: $navigationPath
                    )
                    .toolbar(.hidden, for: .tabBar)
                }
            }
            .padding(EdgeInsets(
                top: AppSpacing.space24,
                leading: AppSpacing.space16,
                bottom: 0,
                trailing: AppSpacing.space16))
            .background(.ypWhite)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    var searchButton: some View {
        Button {
            guard let arrivalStation = viewModel.arrivalStation,
                  let departureStation = viewModel.departureStation else {
                return
            }
            
            navigationPath.append(RouteSearchPath.shedule(
                departureStation: departureStation,
                arrivalStation: arrivalStation)
            )
        } label: {
            Text("Найти")
                .font(AppFont.bold17)
                .foregroundStyle(.white)
                .frame(width: 150, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.size16)
                        .fill(.ypBlue)
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    RouteSearchView(networkServiceProvider: MockNetworkServiceProvider())
}
