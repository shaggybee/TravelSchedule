//
//  StoriesGroupView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 07.08.2026.
//

import SwiftUI

struct StoriesGroupView: View {
    private let stories: [Story]
    private let onStoryTap: Handler<UUID>
    
    init(
        stories: [Story],
        onStoryTap: @escaping Handler<UUID>
    ) {
        self.stories = stories
        self.onStoryTap = onStoryTap
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: AppSpacing.space12) {
                ForEach(stories, id: \.id) { story in
                    getStoryView(for: story)
                }
            }
            .padding(.horizontal, AppSpacing.space16)
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, AppSpacing.space24)
    }
    
    private func getStoryView(for story: Story) -> some View {
        ZStack {
            Image(story.imagePreview)
            
            VStack {
                Spacer()
                
                Text(story.description)
                    .lineLimit(Constants.textLineLimit)
                    .font(AppFont.regular12)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, AppSpacing.space8)
            .padding(.bottom, AppSpacing.space12)
        }
        .frame(width: Constants.storyWidth, height: Constants.storyHeight)
        .clipShape(.rect(cornerRadius: AppRadius.size16))
        .overlay {
            if !story.isViewed {
                RoundedRectangle(cornerRadius: AppRadius.size16)
                    .strokeBorder(.ypBlue, lineWidth: AppBorder.size4)
            } else {
                RoundedRectangle(cornerRadius: AppRadius.size16)
                    .fill(.ypBlackFixed.opacity(Constants.opacity))
            }
        }
        .contentShape(
            RoundedRectangle(cornerRadius: AppRadius.size16)
        )
        .onTapGesture {
            onStoryTap(story.id)
        }
    }
}

// MARK: - Constants
private extension StoriesGroupView {
    enum Constants {
        static let textLineLimit = 3
        static let storyHeight: Double = 140
        static let storyWidth: Double = 92
        static let opacity: Double = 0.5
    }
}

#Preview {
    StoriesGroupView(stories: Story.mockStoriesList) { _ in }
}
