//
//  RoutePointSelectionView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct RoutePointSelectionView: View {
    var departureStationName: String?
    var arrivalStationName: String?
    
    var onRoutePointTypeSelected: Handler<RoutePointType>?
    var onRoutePointsSwap: Completion?
    
    var body: some View {
        HStack(spacing: AppSpacing.space16) {
            VStack(alignment: .leading, spacing: 0) {
                routePoint(
                    title: departureStationName,
                    placeholder: "Откуда") {
                        onRoutePointTypeSelected?(.departure)
                    }
                
                routePoint(
                    title: arrivalStationName,
                    placeholder: "Куда") {
                        onRoutePointTypeSelected?(.arrival)
                    }
            }
            .clipShape(.rect(cornerRadius: AppRadius.size20))
            
            Button {
                onRoutePointsSwap?()
            } label: {
                Image(.swap)
            }
            .frame(width: Constants.buttonSwapSize, height: Constants.buttonSwapSize)
            .background(
                Circle()
                    .fill(.white)
            )
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.size20)
                .fill(.ypBlue)
        )
    }
    
    private func routePoint(
        title: String?,
        placeholder: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title ?? placeholder)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: Constants.routePointButtonHeight)
                .padding(.horizontal, AppSpacing.space16)
                .font(AppFont.regular17)
                .foregroundStyle(
                    title == nil
                    ? .ypGray
                    : .ypBlackFixed
                )
                .lineLimit(1)
                .truncationMode(.tail)
                .background(.white)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Constants
private extension RoutePointSelectionView {
    enum Constants {
        static let buttonSwapSize: Double = 36
        static let routePointButtonHeight: Double = 48
    }
}

#Preview {
    RoutePointSelectionView()
}
