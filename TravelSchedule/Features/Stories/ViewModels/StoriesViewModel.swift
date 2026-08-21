//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 07.08.2026.
//

import Foundation
import Combine

@MainActor
final class StoriesViewModel: ObservableObject {
    // MARK: - Public properties
    @Published private(set) var currentStoryIndex: Int
    @Published private(set) var storyProgress: Double = 0
    @Published private(set) var shouldDismiss: Bool = false
    @Published private(set) var viewedStoryId: UUID?
    
    var currentStory: Story {
        stories[currentStoryIndex]
    }
    
    var numberOfStories: Int {
        stories.count
    }
    
    // MARK: - Private properties
    private let stories: [Story]
    private var timer: Timer?
    
    init(stories: [Story], currentStoryId: UUID) {
        self.stories = stories
        
        guard let storyIndex = stories.firstIndex(where: { $0.id == currentStoryId }) else {
            self.currentStoryIndex = 0
            
            return
        }
        
        currentStoryIndex = storyIndex
    }
    
    // MARK: - Public methods
    func startStoryPlayback() {
        timer = Timer.scheduledTimer(
            withTimeInterval: Constants.storyPlaybackTickInterval,
            repeats: true) { [weak self] _ in
            self?.handlePlaybackTick()
        }
    }
    
    func stopStoryPlayback() {
        timer?.invalidate()
        timer = nil
    }
    
    func nextStory() {
        stopStoryPlayback()
        
        if currentStoryIndex == numberOfStories - 1 {
            completeCurrentStory()
            
            shouldDismiss = true
            
            return
        }
        
        switchToStory(at: currentStoryIndex + 1)
    }
    
    func previousStory() {
        if currentStoryIndex == 0 {
            return
        }
        
        stopStoryPlayback()
        switchToStory(at: currentStoryIndex - 1)
    }
    
    // MARK: - Private methods
    private func handlePlaybackTick() {
        let progress = storyProgress + Constants.storyPlaybackTickInterval / Constants.storyDuration
        
        if progress >= Constants.maxProgress {
            nextStory()
        } else {
            storyProgress = progress
        }
    }
    
    private func switchToStory(at index: Int) {
        completeCurrentStory()
        
        storyProgress = 0
        currentStoryIndex = index
        
        startStoryPlayback()
    }
    
    private func completeCurrentStory() {
        viewedStoryId = currentStory.id
    }
}

// MARK: - Constants
private extension StoriesViewModel {
    enum Constants {
        static let storyDuration: Double = 10
        static let storyPlaybackTickInterval: Double = 0.05
        static let maxProgress: Double = 1
    }
}
