//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 06.08.2026.
//

import Foundation
import SwiftUI

struct UserAgreementView: View {
    @State private var webViewState: WebViewState = .loading
    
    private let viewModel = UserAgreementViewModel()
    
    var body: some View {
        ZStack {
            AppWebView(
                state: $webViewState,
                urlString: "https://yandex.ru/legal/practicum_offer/ru/",
                contentController: viewModel.webViewContentController
            )
                .background(.ypWhite)
            
            if case .loading = webViewState {
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            }
            
            if case .error(let error) = webViewState {
                ErrorStateView(error: error)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    UserAgreementView()
}
