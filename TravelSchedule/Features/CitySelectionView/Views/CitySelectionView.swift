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
        viewModel: CitySelectionViewModel,
        onCitySelected: @escaping Handler<Settlement>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)

        self.onCitySelected = onCitySelected
        
        viewModel.fetchCities()
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
                .background(.ypWhite)
                .onTapGesture {
                    isSearchFocused = false
                }
            case .error(let error):
                ErrorStateView(error: error)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            }
        }
    }
    
    private var content: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredSettlements, id: \.hashValue) { settlement in
                    ListRowView(title: settlement.title ?? "") {
                        onCitySelected(settlement)
                    }
                    .frame(height: Constants.listRowViewHeight)
                }
            }
        }
    }
}

// MARK: - Constants
private extension CitySelectionView {
    enum Constants {
        static let listRowViewHeight: Double = 60
    }
}

#Preview {
    let viewModel = CitySelectionViewModel(networkServiceProvider: MockNetworkServiceProvider())
    
    CitySelectionView(viewModel: viewModel) { _ in }
}
