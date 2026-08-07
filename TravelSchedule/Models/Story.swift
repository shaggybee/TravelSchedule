//
//  Story.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 07.08.2026.
//

import Foundation

struct Story {
    let id: UUID = UUID()
    let imageFull: String
    let imagePreview: String
    let title: String
    let description: String
    var isViewed: Bool = false
}

// MARK: - Mocks
extension Story {
    static let mockStoriesList: [Story] = [
        Story(
            imageFull: "StoryFull_1",
            imagePreview: "StoryPreview_1",
            title: "В добрый путь",
            description: "Каждое путешествие начинается с первого километра.",
        ),
        Story(
            imageFull: "StoryFull_2",
            imagePreview: "StoryPreview_2",
            title: "Забота в дороге",
            description: "Поездка становится приятнее, когда всё продумано до мелочей.",
        ),
        Story(
            imageFull: "StoryFull_3",
            imagePreview: "StoryPreview_3",
            title: "Навстречу приключениям",
            description: "Каждая поездка объединяет людей и новые истории.",
        ),
        Story(
            imageFull: "StoryFull_4",
            imagePreview: "StoryPreview_4",
            title: "Момент спокойствия",
            description: "Иногда самое ценное в дороге — возможность просто отдохнуть.",
        ),
        Story(
            imageFull: "StoryFull_5",
            imagePreview: "StoryPreview_5",
            title: "Через любые пейзажи",
            description: "Поезда продолжают путь в любое время года.",
        ),
        Story(
            imageFull: "StoryFull_6",
            imagePreview: "StoryPreview_6",
            title: "Новые горизонты",
            description: "Путешествия открывают удивительные места и впечатления.",
        ),
        Story(
            imageFull: "StoryFull_7",
            imagePreview: "StoryPreview_7",
            title: "Дорога объединяет",
            description: "У каждого пассажира своя цель, но путь у всех общий.",
        ),
        Story(
            imageFull: "StoryFull_8",
            imagePreview: "StoryPreview_8",
            title: "Живые эмоции",
            description: "В дороге всегда есть место неожиданным моментам.",
        ),
        Story(
            imageFull: "StoryFull_9",
            imagePreview: "StoryPreview_9",
            title: "Путь продолжается",
            description: "Отдыхайте в дороге и просыпайтесь ближе к месту назначения.",
        )
    ]
}
