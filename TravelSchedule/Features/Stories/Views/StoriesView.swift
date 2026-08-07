//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 07.08.2026.
//

import SwiftUI

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: StoriesViewModel
    
    private let onStoryViewed: Handler<UUID>
    
    init(viewModel: StoriesViewModel, onStoryViewed: @escaping Handler<UUID>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        self.onStoryViewed = onStoryViewed
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(viewModel.currentStory.imageFull)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                    .clipped()
                
                VStack(spacing: AppSpacing.space4) {
                    HStack {
                        Spacer()
                        
                        closeButton
                    }
                    .padding(.horizontal, AppSpacing.space12)
                    
                    Spacer()
                    
                    descriptionBlock
                }
            }
            .clipShape(.rect(cornerRadius: AppRadius.size40))
            .background(.ypBlackFixed)
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.close)
        }
        .frame(width: 30, height: 30)
        .foregroundStyle(.white)
        .background(Circle().fill(.ypBlackFixed))
    }
    
    private var descriptionBlock: some View {
        VStack(alignment: .leading, spacing: AppSpacing.space16) {
            Text(viewModel.currentStory.title)
                .font(AppFont.bold34)
                .foregroundStyle(.white)
                .lineLimit(2)
            
            Text(viewModel.currentStory.description)
                .font(AppFont.regular20)
                .foregroundStyle(.white)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppSpacing.space16)
        .padding(.bottom, AppSpacing.space40)
    }
}

#Preview {
    let viewModel = StoriesViewModel(
        stories: Story.mockStoriesList,
        currentStoryId: Story.mockStoriesList[6].id
    )
    
    StoriesView(viewModel: viewModel) { _ in }
}
