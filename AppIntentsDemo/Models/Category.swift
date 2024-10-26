//
//  Category.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко
//

import SwiftUI

enum Category: String, CaseIterable {
    case food = "Еда"
    case health = "Здоровье"
    case clothes = "Одежда"
    case rest = "Отдых"
    
    var color: Color {
        switch self {
        case .clothes: return Color.clothes
        case .health: return Color.health
        case .food: return Color.food
        case .rest: return Color.rest
        }
    }
}
