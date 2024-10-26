//
//  AddExpenseIntent.swift
//  AppIntentsDemo
//
//  Created by Anastasiia Ishchenko on 02.11.2024.
//

import AppIntents
import SwiftUI

struct AddExpenseIntent: AppIntent {
    
    static var title = LocalizedStringResource("Добавить расход")
    static var description = IntentDescription("Сохраняет информацию о расходе")
    
    @Parameter(title: "Категория")
    var category: Category?
    @Parameter(title: "Сумма")
    var amount: Double?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Добавить трату \(\.$amount)р. в категорию: \(\.$category)")
    }
    
    init() {}
    
    init(category: Category?, amount: Double?) {
        self.category = category
        self.amount = amount
    }
    
    @MainActor
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        if amount == nil {
            amount = try await $amount.requestValue(.init(stringLiteral: "Сколько денег вы потратили?"))
        }
        if category == nil {
            category = try await $category.requestValue(.init(stringLiteral: "На что вы их потратили?"))
        }
        
        ExpenseStore.shared.addExpense(category: category!, amount: amount!)
        
        return .result(
            dialog: "Сохранили трату \(amount!, specifier: "%.0fр.") для категории: \(category!)",
            view: ChartView(
                expensesModel: ExpenseStore.shared.chartExpensesData,
                totalExpense: ExpenseStore.shared.totalExpense,
                showTotalExpense: false
            )
        )
    }
}


extension Category: AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Категория")
    static var typeDisplayName: LocalizedStringResource = "Категория"
    
    static var caseDisplayRepresentations: [Category : DisplayRepresentation] = [
        .clothes: .init(stringLiteral: "Одежда"),
        .food: .init(stringLiteral: "Еда"),
        .health: .init(stringLiteral: "Здоровье"),
        .other: .init(stringLiteral: "Другое")
    ]
}
