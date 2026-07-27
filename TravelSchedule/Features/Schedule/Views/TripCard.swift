//
//  TripCard.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import SwiftUI

struct TripCard: View {
    private let trip: Trip
    private let onTap: () -> Void
    
    init(trip: Trip, onTap: @escaping () -> Void) {
        self.trip = trip
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.space18) {
            HStack(alignment: .top, spacing: AppSpacing.space8) {
                
                AsyncImage(url: URL(string: trip.carrierLogo ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color(.ypGray)
                }
                .frame(width: 38, height: 38)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.size12))
                
                VStack(alignment: .leading, spacing: AppSpacing.space2) {
                    Text(trip.carrierTitle ?? "")
                        .font(AppFont.regular17)
                        .foregroundStyle(.ypBlackFixed)
                    
                    if let transferCity = trip.transferCity {
                        Text("С пересадкой в \(transferCity)")
                            .font(AppFont.regular12)
                            .foregroundStyle(.ypRed)
                    }
                }
                
                Spacer()
                
                Text(formatDate(trip.startDate))
                    .font(AppFont.regular12)
                    .foregroundStyle(.ypBlackFixed)
            }
            .padding(.leading, AppSpacing.space14)
            .padding(.trailing, AppSpacing.space8)
            
            HStack(alignment: .center, spacing: AppSpacing.space4) {
                
                Text(trip.departureTime ?? "")
                    .font(AppFont.regular17)
                    .foregroundStyle(.ypBlackFixed)
                
                Rectangle()
                    .fill(.ypGray)
                    .frame(height: 1)
                
                Text(String(formatDuration(trip.duration)))
                    .font(AppFont.regular12)
                    .foregroundStyle(.ypBlackFixed)
                    .fixedSize()
                
                Rectangle()
                    .fill(.ypGray)
                    .frame(height: 1)
                
                Text(trip.arrivalTime ?? "")
                    .font(AppFont.regular17)
                    .foregroundStyle(.ypBlackFixed)
            }
            .padding(.horizontal, AppSpacing.space14)
        }
        .padding(.vertical, AppSpacing.space14)
        .background(.ypLightGray)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.size24))
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.size24))
        .onTapGesture {
            onTap()
        }
    }
    
    private func formatDuration(_ seconds: Int?) -> String {
        guard let seconds else {
            return ""
        }
        
        let days = seconds / 86400
        let hours = (seconds % 86400) / 3600

        switch (days, hours) {
        case (0, _):
            return "\(hours) ч"

        case (_, 0):
            return "\(days) д"

        default:
            return "\(days) д \(hours) ч"
        }
    }
    
    private func formatDate(_ value: String?) -> String {
        guard let value else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.date(from: value) else {
            return ""
        }

        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        
        return formatter.string(from: date)
    }
}

#Preview {
    TripCard(
        trip: Trip(
            departureTime: "01:00",
            arrivalTime: "03:00",
            hasTransfers: true,
            duration: 600000,
            carrierLogo: nil,
            carrierCode: 23,
            carrierTitle: "РЖД",
            transferCity: "Кострома",
            startDate: "2026-07-28"
        ), onTap: { })
}
