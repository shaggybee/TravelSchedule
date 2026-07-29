//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct StationSelectionView: View {
    @StateObject private var viewModel: StationSelectionViewModel
    @FocusState private var isSearchFocused: Bool
    
    private let onStationSelected: (Handler<Station>)
    
    init(
        stations: [Station],
        onStationSelected: @escaping (Handler<Station>)
    ) {
        _viewModel = StateObject(wrappedValue: StationSelectionViewModel(stations: stations))
        
        self.onStationSelected = onStationSelected
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.space16) {
            SearchField(
                text: $viewModel.search,
                isFocused: $isSearchFocused
            )
            .background(.ypWhite)
            
            if viewModel.isStationsEmpty {
                EmptyStateView(text: "Станция не найдена")
            } else {
                content
            }
        }
        .padding(.horizontal, AppSpacing.space16)
        .background(.ypWhite)
        .onTapGesture {
            isSearchFocused = false
        }
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredStations, id: \.hashValue) { station in
                    ListRowView(title: station.title ?? "") {
                        onStationSelected(station)
                    }
                    .frame(height: 60)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StationSelectionView(
        stations: []) { _ in }
}
