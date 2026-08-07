//
//  SelectionRow.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import SwiftUI

struct SelectionRow: View {
    enum SelectionRowStyle {
        case checkbox
        case radio
        
        func image(isSelected: Bool) -> String {
            switch self {
            case .checkbox:
                isSelected
                ? AppSystemIcon.checkmarkSquareFill
                : AppSystemIcon.square
                
            case .radio:
                isSelected
                ? AppSystemIcon.largecircleFillCircle
                : AppSystemIcon.circle
            }
        }
    }
    
    let title: String
    let style: SelectionRowStyle
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppSpacing.space4) {
                
                Text(title)
                    .font(AppFont.regular17)
                    .foregroundStyle(.ypBlack)
                
                Spacer()
                
                Image(systemName: style.image(isSelected: isSelected))
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .foregroundStyle(.ypBlack)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Constants
private extension SelectionRow {
    enum Constants {
        static let imageSize: Double = 20
    }
}

#Preview {
    SelectionRow(
        title: "Показывать варианты с пересадками",
        style: .radio,
        isSelected: false,
        onTap: { }
    )
}
