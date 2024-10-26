//
//  Category.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко
//

import SwiftUI

enum Category: String, CaseIterable, Encodable {
    case food = "Еда"
    case health = "Здоровье"
    case clothes = "Одежда"
    case other = "Другое"
    
    var title: String {
        switch self {
        case .clothes: return "Еда"
        case .health: return "Здоровье"
        case .food: return "Одежда"
        case .other: return "Другое"
        }
    }
    
    var color: Color {
        switch self {
        case .clothes: return Color.clothes
        case .health: return Color.health
        case .food: return Color.food
        case .other: return Color.gray
        }
    }
}
