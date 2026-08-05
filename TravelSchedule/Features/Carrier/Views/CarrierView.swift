//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 27.07.2026.
//

import SwiftUI

struct CarrierView: View {
    @StateObject private var viewModel: CarrierViewModel
    
    init(viewModel: CarrierViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        viewModel.fetchCarrierInfo()
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .idle, .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            case .loaded:
                VStack(spacing: AppSpacing.space16) {
                    if viewModel.hasCarrierInfo {
                        content
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .background(.ypWhite)
                    } else {
                        EmptyStateView(text: "Нет информации о перевозчике")
                    }
                }
                .padding([.top, .horizontal], AppSpacing.space16)
                .background(.ypWhite)
            case .error(let error):
                ErrorStateView(error: error)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: AppSpacing.space16) {
            carrierLogo
                .frame(height: 104)
                .foregroundStyle(.ypBlackFixed)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.size24)
                        .fill(.white)
                )
            
            Text(viewModel.carrierInfo?.name ?? "")
                .font(AppFont.bold24)
            
            VStack {
                getContactLink(with: viewModel.carrierInfo?.email, for: .email)
                
                getContactLink(with: viewModel.carrierInfo?.phone, for: .phone)
                
                getContactLink(with: viewModel.carrierInfo?.url, for: .web)
            }
        }
    }
    
    @ViewBuilder
    private var carrierLogo: some View {
        if let logo = viewModel.carrierInfo?.logo, !logo.isEmpty {
            AsyncImage(url: URL(string: logo)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } else if phase.error != nil {
                    carrierLogoPlaceholder
                } else {
                    LoadingView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.ypWhite)
                }
            }
        } else {
            carrierLogoPlaceholder
        }
        
    }
    
    private var carrierLogoPlaceholder: some View {
        Image(systemName: "train.side.rear.car")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func getContactLink(with value: String?, for scheme: ContactLinkScheme) -> some View {
        VStack(alignment: .leading) {
            Text(scheme.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(AppFont.regular17)
                .foregroundStyle(.ypBlack)
            
            if let value, !value.isEmpty,
               let url = scheme.url(for: value)
            {
                Link(value, destination: url)
                    .font(AppFont.regular12)
                    .foregroundStyle(.ypBlue)
            } else {
                Text("-")
                    .font(AppFont.regular12)
                    .foregroundStyle(.ypBlue)
            }
        }
        .padding(.vertical, AppSpacing.space12)
    }
}

#Preview {
    let viewModel = CarrierViewModel(
        carrierCode: 112,
        networkServiceProvider: MockNetworkServiceProvider()
    )
    
    CarrierView(viewModel: viewModel)
}
