//
//  ExpenseData.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко
//

import SwiftUI

struct Expense {
    let category: Category
    let value: Double
    
    init(_ category: Category, _ value: Double) {
        self.category = category
        self.value = value
    }
}

extension UserDefaults {
    
    static let shared = UserDefaults(suiteName: "group.ru.noorganization.AppIntentsDemo")!
}

class ExpenseStore: ObservableObject {
    
    @Published var expenses: [Category: Double] {
        didSet {
            let dict = Dictionary(
                uniqueKeysWithValues: expenses.compactMap { (key, value) in
                    (key.rawValue, value)
                }
            )
            UserDefaults.shared.set(dict, forKey: "expenses")
            update()
        }
    }
    
    @Published var chartExpensesData: [Expense] = []
    
    @Published var totalExpense: Double = 0
    
    static let shared = ExpenseStore()
    
    private init() {
        if let data = UserDefaults.shared.dictionary(forKey: "expenses") as? [String: Double] {
            self.expenses = Dictionary(
                uniqueKeysWithValues: data.compactMap { (key, value) in
                    if let category = Category(rawValue: key) {
                        (category, value)
                    } else {
                        nil
                    }
                }
            )
            update()
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
    
    
    func clearStorage() {
        var tempExpenses: [Category: Double] = [:]
        expenses.keys.forEach { tempExpenses[$0] = 0 }
        expenses = tempExpenses
    }
    
    func updateData() {
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
            update()
        } else {
            self.expenses = Dictionary(
                uniqueKeysWithValues: Category.allCases.map {
                    ($0, 0)
                }
            )
        }
    }
    
    private func update() {
        chartExpensesData = expenses.compactMap { (key, value) in
            Expense(key, value)
        }.sorted(by: {
            $0.value > $1.value
        })
        totalExpense = expenses.values.reduce(0, +)
    }
}
