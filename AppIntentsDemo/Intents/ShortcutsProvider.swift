//
//  ShortcutsProvider.swift
//  AppIntentsDemo
//
//  Created by Anastasiia Ishchenko on 30.10.2024.
//

import AppIntents

struct ShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetTotalExpenseIntent(),
            phrases: ["Получить общую сумму расходов в \(.applicationName)"],
            shortTitle: "Получить общую сумму расходов",
            systemImageName: "dollarsign.circle.fill"
        )
        
        AppShortcut(
            intent: AddExpenseIntent(),
            phrases: ["Добавить расход в \(.applicationName)"],
            shortTitle: "Добавить расход",
            systemImageName: "dollarsign.circle.fill"
        )
        AppShortcut(
            intent: GetExpensesChartIntent(),
            phrases: ["Посмотреть статистику по тратам в \(.applicationName)"],
            shortTitle: "Посмотреть статистику по тратам",
            systemImageName: "dollarsign.circle.fill"
        )
    }
}
