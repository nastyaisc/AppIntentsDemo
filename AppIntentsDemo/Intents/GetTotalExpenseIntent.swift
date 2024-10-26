//
//  GetTotalExpense.swift
//  AppIntentsDemo
//
//  Created by Anastasiia Ishchenko on 30.10.2024.
//

import AppIntents

struct GetTotalExpenseIntent: AppIntent {
    
    static var title = LocalizedStringResource("Получить общую сумму расходов")
    static var description = IntentDescription("Показывает общую сумму расходов")
    
    func perform() async throws -> some ReturnsValue<Double> & ProvidesDialog {
        let store = ExpenseStore.shared
        let amount = store.expenses.reduce(Double(0)) { (result, element) in
            result + element.value
        }
        return .result(
            value: amount,
            dialog: .init("Вы потратили \(amount, specifier: "%.0fр.").")
        )
    }
}
