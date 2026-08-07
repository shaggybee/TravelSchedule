//
//  UserAgreementViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 06.08.2026.
//

import SwiftUI
import WebKit

final class UserAgreementViewModel {
    
    // MARK: - Public properties
    var webViewContentController: WKUserContentController {
        let contentController = WKUserContentController()
        
        contentController.addUserScript(
            WKUserScript(
                source: getScriptForUpdateAgreementPage(),
                injectionTime: .atDocumentEnd,
                forMainFrameOnly: true
            )
        )
        
        return contentController
    }
    
    // MARK: - Private properties
    @AppStorage(AppStorageKey.isDarkMode) private var isDarkMode = false
    
    
    // MARK: - Private methods
    private func getScriptForUpdateAgreementPage() -> String {
        let backgroundColor = getColorHexForTheme(color: .ypWhite)
        let textColor = getColorHexForTheme(color: .ypBlack)
        
        // На странице находим нужные блоки для вывода: заголовок (dc-doc-page-title) и сам контент (dc-doc-page__body).
        // Формируем из них тело html страницы. Заменяем стили на кастомные через document.head.innerHTML.
        // При изменении Яндексом верстки, скрипт может работать не корректно, так как привязываемся к классам для поиска соответствующих блоков.
        let script = """
            (() => {
                const header = document.querySelector(".\(Constants.pageTitleClass)");
                const content = document.querySelector(".\(Constants.pageBodyClass)");
        
                document.head.innerHTML = `
                    <style>
                        body {
                            font-family: -apple-system;
                            color: \(textColor);
                            background-color: \(backgroundColor);
                            padding: 0 4px;
                        }
            
                        h1, h2 {
                            font-size: 24px;
                        }
            
                        li {
                            display: list-item;
                        }
            
                        div {
                            overflow: hidden;
                        }
                    </style>
                `;
        
                document.body.innerHTML = `${header?.outerHTML ?? ""} ${content?.outerHTML ?? ""}`;
            })();
        """
        
        return script
    }
    
    private func getColorHexForTheme(color: UIColor) -> String {
        let resolvedColor = color.resolvedColor(
            with: UITraitCollection(userInterfaceStyle: isDarkMode ? .dark : .light)
        )
        
        return resolvedColor.hex
    }
}

// MARK: - Constants
private extension UserAgreementViewModel {
    enum Constants {
        static let pageTitleClass = "dc-doc-page-title"
        static let pageBodyClass = "dc-doc-page__body"
    }
}
