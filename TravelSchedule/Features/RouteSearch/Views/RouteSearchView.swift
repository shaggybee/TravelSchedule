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
            VStack(spacing: AppSpacing.space20) {
                StoriesGroupView(stories: viewModel.stories) { _ in }
                    .fixedSize(horizontal: false, vertical: true)
                
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
                .padding(.horizontal, AppSpacing.space16)
                
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
                case let .schedule(departureStation, arrivalStation):
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
            .frame(maxHeight: .infinity)
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
            
            navigationPath.append(RouteSearchPath.schedule(
                departureStation: departureStation,
                arrivalStation: arrivalStation)
            )
        } label: {
            Text("Найти")
                .font(AppFont.bold17)
                .foregroundStyle(.white)
                .frame(width: Constants.searchButtonWidth, height: Constants.searchButtonHeight)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.size16)
                        .fill(.ypBlue)
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Constants
private extension RouteSearchView {
    enum Constants {
        static let searchButtonHeight: Double = 60
        static let searchButtonWidth: Double = 150
    }
}

#Preview {
    RouteSearchView(networkServiceProvider: MockNetworkServiceProvider())
}
