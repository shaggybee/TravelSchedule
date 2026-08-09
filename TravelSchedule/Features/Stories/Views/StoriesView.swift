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
    
    @State private var showDescription: Bool = false
    
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
                    StoriesProgressBar(
                        numberOfSections: viewModel.numberOfStories,
                        currentSection: viewModel.currentStoryIndex + 1,
                        sectionProgress: viewModel.storyProgress)
                    .padding(EdgeInsets(
                        top: AppSpacing.space28,
                        leading: AppSpacing.space12,
                        bottom: AppSpacing.space12,
                        trailing: AppSpacing.space12)
                    )
                    
                    HStack {
                        Spacer()
                        
                        closeButton
                    }
                    .padding(.horizontal, AppSpacing.space12)
                    
                    Spacer()
                    
                    if showDescription {
                        descriptionBlock
                            .transition(.opacity)
                    }
                }
            }
            .animation(.easeInOut(duration: Constants.storyTransitionDuration), value: viewModel.currentStory.id)
            .clipShape(.rect(cornerRadius: AppRadius.size40))
            .background(.ypBlackFixed)
            .onTapGesture { location in
                if location.x < proxy.size.width / 2 {
                    viewModel.previousStory()
                } else {
                    viewModel.nextStory()
                }
            }
            .highPriorityGesture(swipeStoryGesture)
            .simultaneousGesture(storyPauseGesture)
        }
        .onAppear {
            viewModel.startStoryPlayback()
            
            withAnimation(.easeInOut(duration: 1)) {
                showDescription.toggle()
            }
        }
        .onChange(of: viewModel.viewedStoryId) { oldStoryId, newStoryId in
            guard let newStoryId, newStoryId != oldStoryId else {
                return
            }
            
            onStoryViewed(newStoryId)
        }
        .onChange(of: viewModel.shouldDismiss) { _, shouldDismiss in
            if shouldDismiss {
                dismiss()
            }
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.close)
        }
        .frame(width: Constants.closeButtonSize, height: Constants.closeButtonSize)
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
    
    private var swipeStoryGesture: some Gesture {
        DragGesture(minimumDistance: Constants.swipeMinimumDistance, coordinateSpace: .global)
            .onEnded { value in
                let x = value.translation.width
                let y = value.translation.height
                
                guard max(abs(x), abs(y)) >= Constants.swipeDistanceThreshold else {
                    return
                }
                
                if abs(x) > abs(y) {
                    if x < 0 {
                        viewModel.nextStory()
                    } else {
                        viewModel.previousStory()
                    }
                } else if y > 0 {
                    dismiss()
                }
            }
    }
    
    private var storyPauseGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { _ in
                viewModel.stopStoryPlayback()
            }
            .onEnded { _ in
                viewModel.startStoryPlayback()
            }
    }
}

// MARK: - Constants
private extension StoriesView {
    enum Constants {
        static let storyTransitionDuration: CGFloat = 0.5
        static let closeButtonSize: CGFloat = 30
        static let swipeMinimumDistance: CGFloat = 20
        static let swipeDistanceThreshold: CGFloat = 80
    }
}

#Preview {
    let viewModel = StoriesViewModel(
        stories: Story.mockStoriesList,
        currentStoryId: Story.mockStoriesList[2].id
    )
    
    StoriesView(viewModel: viewModel) { _ in }
}
