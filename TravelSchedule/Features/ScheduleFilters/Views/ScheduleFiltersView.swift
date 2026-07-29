//
//  ScheduleFiltersView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import SwiftUI
import Combine

struct ScheduleFiltersView: View {
    @StateObject private var viewModel: ScheduleFiltersViewModel
    
    private let onApply: Handler<ScheduleFilters>
    
    init(viewModel: ScheduleFiltersViewModel, onApply: @escaping Handler<ScheduleFilters>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onApply = onApply
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.space16) {
                Text("Время отправления")
                    .font(AppFont.bold24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    ForEach(DepartureTime.allCases, id: \.self) { time in
                        SelectionRow(
                            title: time.title,
                            style: .checkbox,
                            isSelected: viewModel.isSelected(time)
                        ) {
                            viewModel.toggle(time)
                        }
                        .frame(height: 60)
                    }
                }
                
                Text("Показывать варианты с пересадками")
                    .font(AppFont.bold24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    SelectionRow(
                        title: "Да",
                        style: .radio,
                        isSelected: viewModel.filters.showWithTransfers ?? false
                    ) {
                        viewModel.filters.showWithTransfers = true
                    }
                    .frame(height: 60)
                    
                    SelectionRow(
                        title: "Нет",
                        style: .radio,
                        isSelected: !(viewModel.filters.showWithTransfers ?? true)
                    ) {
                        viewModel.filters.showWithTransfers = false
                    }
                    .frame(height: 60)
                }
            }
        }
        .overlay(alignment: .bottom) {
            if viewModel.isApplyAvailable {
                Button {
                    onApply(viewModel.filters)
                } label: {
                    Text("Применить")
                        .font(AppFont.bold17)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: AppRadius.size16)
                                .fill(.ypBlue)
                        )
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.bottom, AppSpacing.space24)
            }
            
        }
        .padding([.top, .horizontal], AppSpacing.space16)
        .background(.ypWhite)
    }
}

#Preview {
    ScheduleFiltersView(
        viewModel: ScheduleFiltersViewModel(filters: ScheduleFilters()),
        onApply: {_ in }
    )
}
