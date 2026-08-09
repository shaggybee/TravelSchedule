//
//  StoriesProgressBar.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 08.08.2026.
//

import SwiftUI

struct StoriesProgressBar: View {
    let numberOfSections: Int
    let currentSection: Int
    let sectionProgress: CGFloat
    
    var body: some View {
        HStack(spacing: AppSpacing.space6) {
            ForEach(0..<numberOfSections, id: \.self) { index in
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: AppRadius.size3)
                            .fill(.white)
                        
                        RoundedRectangle(cornerRadius: AppRadius.size3)
                            .fill(.ypBlue)
                            .frame(
                                width: min(
                                    getProgress(for: index + 1) * geometry.size.width,
                                    geometry.size.width
                                )
                            )
                    }
                }
            }
        }
        .frame(height: Constants.sectionHeight)
    }
    
    private func getProgress(for section: Int) -> Double {
        switch section {
        case ..<currentSection: Constants.maxProgress
        case currentSection: sectionProgress
        default: Constants.minProgress
        }
    }
}

// MARK: - Constants
private extension StoriesProgressBar {
    enum Constants {
        static let minProgress: Double = 0
        static let maxProgress: Double = 1
        static let sectionHeight: CGFloat = 6
    }
}

#Preview {
    Color.ypGray
        .ignoresSafeArea()
        .overlay {
            StoriesProgressBar(
                numberOfSections: 5,
                currentSection: 3,
                sectionProgress: 0.5
            )
            .padding()
        }
}
