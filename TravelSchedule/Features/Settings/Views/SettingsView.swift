//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 25.07.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(AppStorageKey.isDarkMode) private var isDarkMode = false
    
    private let viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                themeToggleRow
                
                NavigationLink {
                    UserAgreementView()
                        .toolbar(.hidden, for: .tabBar)
                        .navigationTitle("Пользовательское соглашение")
                } label: {
                    userAgreementRow
                }
                
                Spacer()
                
                footer
            }
            .padding(.vertical, AppSpacing.space24)
            .padding(.horizontal, AppSpacing.space16)
            .background(.ypWhite)
        }
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var themeToggleRow: some View {
        HStack(spacing: AppSpacing.space4) {
            Text("Темная тема")
                .foregroundStyle(.ypBlack)
                .font(AppFont.regular17)
            
            Spacer()
            
            Toggle("", isOn: $isDarkMode)
                .tint(.ypBlue)
                .labelsHidden()
        }
        .frame(height: Constants.rowHeight)
    }
    
    private var userAgreementRow: some View {
        HStack(spacing: AppSpacing.space4) {
            Text("Пользовательское соглашение")
                .foregroundStyle(.ypBlack)
                .font(AppFont.regular17)
            
            Spacer()
            
            Image(.chevronRight)
                .foregroundStyle(.ypBlack)
                .frame(width: Constants.imageSize, height: Constants.imageSize)
        }
        .frame(height: Constants.rowHeight)
        .contentShape(Rectangle())
    }
    
    private var footer: some View {
        VStack(spacing: AppSpacing.space16) {
            Text("Приложение использует API «Яндекс.Расписания»")
            Text("Версия \(viewModel.appVersion)")
        }
        .foregroundStyle(.ypBlack)
        .font(AppFont.regular12)
    }
}

// MARK: - Constants
private extension SettingsView {
    enum Constants {
        static let imageSize: Double = 24
        static let rowHeight: Double = 60
    }
}

#Preview {
    SettingsView()
}
