//
//  ListRowView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct ListRowView: View {
    let title: String
    let onSelect: Completion

    var body: some View {
        Button {
            onSelect()
        } label: {
            HStack {
                Text(title)
                    .font(AppFont.regular17)
                    .foregroundStyle(.ypBlack)

                Spacer()

                Image(.chevronRight)
                    .foregroundStyle(.ypBlack)
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(.ypWhite)
    }
}

// MARK: - Constants
private extension ListRowView {
    enum Constants {
        static let imageSize: Double = 24
    }
}

#Preview {
    ListRowView(
        title: "Row") { }
}
