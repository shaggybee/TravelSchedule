//
//  LoadingView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}

#Preview {
    LoadingView()
}
