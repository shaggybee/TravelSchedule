//
//  EmptyStateView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct EmptyStateView: View {
    let text: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(AppFont.bold24)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptyStateView(text: "ничего нет")
}
