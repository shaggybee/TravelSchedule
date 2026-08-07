//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 07.08.2026.
//

import Foundation
import Combine

final class StoriesViewModel: ObservableObject {
    // MARK: - Public properties
    var currentStoryIndex: Int
    var currentStory: Story
    
    // MARK: - Private properties
    private let stories: [Story]
    private var currentStoryId: UUID
    
    init(stories: [Story], currentStoryId: UUID) {
        self.stories = stories
        
        guard let storyIndex = stories.firstIndex(where: { $0.id == currentStoryId }) else {
            currentStoryIndex = 0
            currentStory = stories[currentStoryIndex]
            self.currentStoryId = currentStory.id
         
            return
        }
        
        self.currentStoryId = currentStoryId
        currentStoryIndex = storyIndex
        currentStory = stories[storyIndex]
    }
}
