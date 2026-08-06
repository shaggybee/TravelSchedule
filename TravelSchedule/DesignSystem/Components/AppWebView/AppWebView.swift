//
//  AppWebView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 06.08.2026.
//

import Foundation
import SwiftUI
import WebKit

struct AppWebView: UIViewRepresentable {
    // MARK: - Public properties
    @Binding var state: WebViewState
    
    let urlString: String
    let contentController: WKUserContentController?
    
    // MARK: - Public methods
    func makeUIView(context: Context) -> some UIView {
        let webView = getWebView(contentController: contentController)
        
        guard let url = URL(string: urlString) else {
            state = .error(.apiError)
            
            return webView
        }
        
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(state: $state)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    // MARK: - Private methods
    private func getWebView(contentController: WKUserContentController?) -> WKWebView {
        guard let contentController else {
            return WKWebView()
        }
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
}
