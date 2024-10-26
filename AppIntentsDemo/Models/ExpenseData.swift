//
//  ExpenseData.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко
//

import SwiftUI

class ExpenseData: ObservableObject {
    @Published var expenses: [Category: Double] {
        didSet {
            let dict = Dictionary(
                uniqueKeysWithValues: expenses.compactMap { (key, value) in
                    (key.rawValue, value)
                }
            )
            UserDefaults.standard.set(dict, forKey: "expenses")
        }
    }
    
    init() {
        // Загружаем данные из UserDefaults при запуске
        if let data = UserDefaults.standard.dictionary(forKey: "expenses") as? [String: Double] {
            self.expenses = Dictionary(
                uniqueKeysWithValues: data.compactMap { (key, value) in
                    if let category = Category(rawValue: key) {
                        (category, value)
                    } else {
                        nil
                    }
                }
            )
        } else {
            self.expenses = Dictionary(
                uniqueKeysWithValues: Category.allCases.map {
                    ($0, 0)
                }
            )
        }
    }
    
    func addExpense(category: Category, amount: Double) {
        expenses[category, default: 0] += amount
    }
}
