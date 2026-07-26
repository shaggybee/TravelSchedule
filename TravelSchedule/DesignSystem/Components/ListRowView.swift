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

                Image(systemName: "chevron.right")
                    .foregroundStyle(.ypBlack)
                    .frame(width: 24, height: 24)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(.ypWhite)
    }
}

#Preview {
    ListRowView(
        title: "Row") { }
}
