//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel: ScheduleViewModel
    @Binding private var navigationPath: NavigationPath
    
    init(
        viewModel: ScheduleViewModel,
        navigationPath: Binding<NavigationPath>
    ) {
        _navigationPath = navigationPath
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .idle, .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            case .loaded:
                VStack(spacing: AppSpacing.space16) {
                    Text(viewModel.routeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(AppFont.bold24)
                        .foregroundStyle(.ypBlack)
                    
                    if viewModel.filteredTrips.isEmpty {
                        EmptyStateView(text: "Вариантов нет")
                    } else {
                        content
                    }
                }
                .padding([.top, .horizontal], AppSpacing.space16)
                .background(.ypWhite)
                .navigationDestination(for: SchedulePath.self) {
                    navigationDestination(path: $0)
                }
                .overlay(alignment: .bottom) {
                    filterButton
                }
            case .error(let error):
                ErrorStateView(error: error)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            }
        }.task {
            await viewModel.fetchSchedule()
        }
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(spacing: AppSpacing.space8) {
                ForEach(viewModel.filteredTrips, id: \.uid) { trip in
                    TripCard(trip: trip, onTap: {
                        navigationPath.append(SchedulePath.carrier(code: trip.carrierCode))
                    })
                    .frame(height: Constants.tripCardHeight)
                }
            }
            .padding(.bottom, Constants.tripCardsStackBottomPadding)
        }
        .scrollIndicators(.hidden)
    }
    
    private var filterButton: some View {
        Button {
            navigationPath.append(SchedulePath.scheduleFilters)
        } label: {
            HStack {
                Text("Уточнить время")
                    .font(AppFont.bold17)
                    .foregroundStyle(.white)
                
                if viewModel.hasActiveFilters {
                    Circle()
                        .fill(.ypRed)
                        .frame(
                            width: Constants.activeFilterIndicatorSize,
                            height: Constants.activeFilterIndicatorSize)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: Constants.filtersButtonHeight)
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: AppRadius.size16)
                    .fill(.ypBlue)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, AppSpacing.space16)
        .padding(.bottom, AppSpacing.space24)
    }
    
    private func navigationDestination(path: SchedulePath) -> some View {
        Group {
            switch path {
            case .scheduleFilters:
                let scheduleFiltersViewModel = ScheduleFiltersViewModel(
                    filters: viewModel.scheduleFilters
                )
                
                ScheduleFiltersView(
                    viewModel: scheduleFiltersViewModel) { filters in
                        viewModel.setFilters(filters)
                        
                        navigationPath.removeLast()
                    }
            case .carrier(let code):
                let carrierViewModel = CarrierViewModel(
                    carrierCode: code,
                    networkServiceProvider: viewModel.networkServiceProvider)
                
                CarrierView(viewModel: carrierViewModel)
            }
        }
    }
}

// MARK: - Constants
private extension ScheduleView {
    enum Constants {
        static let tripCardHeight: CGFloat = 104
        static let tripCardsStackBottomPadding: CGFloat = 92
        static let filtersButtonHeight: CGFloat = 60
        static let activeFilterIndicatorSize: CGFloat = 8
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    
    let viewModel = ScheduleViewModel(
        departureStation: Station(title: "Первомайская", code: "12"),
        arrivalStation: Station(title: "Мичурина", code: "11"),
        networkServiceProvider: MockNetworkServiceProvider()
    )
    
    ScheduleView(viewModel: viewModel, navigationPath: $navigationPath)
}
