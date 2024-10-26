//
//  GetExpensesChart.swift
//  AppIntentsDemo
//
//  Created by Anastasiia Ishchenko on 06.11.2024.
//

import AppIntents
import SwiftUI

struct GetExpensesChartIntent: AppIntent {
    
    static var title = LocalizedStringResource("Посмотреть статистику по тратам")
    static var description = IntentDescription("Демонстрирует статистику по тратам")
    
    @MainActor
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        let totalExpenses = (try? await GetTotalExpenseIntent().perform().value) ?? 0
        return .result(
            dialog: "Всего вы потратили \(totalExpenses, specifier: "%.0fр.")",
            view: ChartView(
                expensesModel: ExpenseStore.shared.chartExpensesData,
                totalExpense: totalExpenses,
                showTotalExpense: false
            )
        )
    }
}
