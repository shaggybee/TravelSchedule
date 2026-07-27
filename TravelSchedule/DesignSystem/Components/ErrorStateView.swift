//
//  ErrorStateView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 26.07.2026.
//

import SwiftUI

struct ErrorStateView: View {
    let error: NetworkError
    
    var body: some View {
        VStack(spacing: AppSpacing.space16) {
            image
            
            text
                .font(AppFont.bold24)
        }
        .background(.ypWhite)
    }
    
    private var image: some View {
        switch error {
        case .apiError:
            Image(.serverError)
        case .noInternet:
            Image(.noInternetError)
        }
    }
    
    private var text: some View {
        switch error {
        case .apiError:
            Text("Ошибка сервера")
        case .noInternet:
            Text("Нет интернета")
        }
    }
}

#Preview {
    ErrorStateView(error: .apiError)
}
