//
//  WebViewCoordinator.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 06.08.2026.
//

import SwiftUI
import WebKit

final class WebViewCoordinator: NSObject, WKNavigationDelegate {
    // MARK: - Public properties
    @Binding var state: WebViewState
    
    init(state: Binding<WebViewState>) {
        _state = state
    }
    
    // MARK: - Public methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        state = .loading
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        state = .loaded
    }
    
    func webView(
        _ webView: WKWebView,
        didFail navigation: WKNavigation!,
        withError error: Error
    ) {
        let networkError = mapError(error as NSError)
        
        state = .error(networkError)
    }
    
    func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        let networkError = mapError(error as NSError)
        
        state = .error(networkError)
    }
    
    // MARK: - Private methods
    private func mapError(_ error: NSError) -> NetworkError {
        let nsError = error as NSError
        
        guard nsError.domain == NSURLErrorDomain else {
            return .apiError
        }
        
        switch URLError.Code(rawValue: nsError.code) {
        case .dataNotAllowed,
                .notConnectedToInternet,
                .networkConnectionLost,
                .cannotFindHost,
                .cannotConnectToHost,
                .timedOut:
            return .noInternet
        default:
            return .apiError
        }
    }
}
