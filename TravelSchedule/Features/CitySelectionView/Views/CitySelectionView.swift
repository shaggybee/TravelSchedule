//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI
import Combine

struct CitySelectionView: View {
    @StateObject private var viewModel: CitySelectionViewModel
    
    @FocusState private var isSearchFocused: Bool
    
    private let onCitySelected: Handler<Settlement>
    
    init(
        networkServiceProvider: NetworkServiceProviderProtocol,
        onCitySelected: @escaping Handler<Settlement>
    ) {
        _viewModel = StateObject(
            wrappedValue: CitySelectionViewModel(networkServiceProvider: networkServiceProvider)
        )

        self.onCitySelected = onCitySelected
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                LoadingView()
            case .loaded:
                VStack(spacing: AppSpacing.space16) {
                    SearchField(
                        text: $viewModel.search,
                        isFocused: $isSearchFocused
                    )
                    
                    if viewModel.isSettlementsEmpty {
                        EmptyStateView(text: "Город не найден")
                    } else {
                        content
                    }
                }
                .padding(.horizontal, AppSpacing.space16)
                .onTapGesture {
                    isSearchFocused = false
                }
            case .error(let error):
                ErrorStateView(error: error)
            default:
                VStack {
                    
                }
            }
        }
        .onAppear {
            viewModel.fetchCities()
        }
    }
    
    private var content: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredSettlements, id: \.hashValue) { settlement in
                    ListRowView(title: settlement.title ?? "") {
                        onCitySelected(settlement)
                    }
                    .frame(height: 60)
                }
            }
        }
    }
}

#Preview {
    CitySelectionView(
        networkServiceProvider: MockNetworkServiceProvider()) { _ in }
}
