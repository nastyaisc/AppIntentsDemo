//
//  ChartView.swift
//  AppIntentsDemo
//
//  Created by Anastasiia Ishchenko on 03.11.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let expensesModel: [Expense]
    let totalExpense: Double
    let showTotalExpense: Bool
    
    var body: some View {
        Chart {
            ForEach(expensesModel, id: \.category.rawValue) { expense in
                SectorMark(
                    angle: .value("Expense", expense.value),
                    innerRadius: .ratio(0.65),
                    angularInset: 2.0
                )
                .foregroundStyle(by: .value("Type", expense.category.rawValue))
            }
        }
        .chartForegroundStyleScale(
            domain: expensesModel.map  { $0.category.rawValue },
            range: expensesModel.map { $0.category.color }
        )
        .chartLegend(.hidden)
        .chartBackground { _ in
            if totalExpense != 0, showTotalExpense {
                Text("\(totalExpense, specifier: "%.0fр.")")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(
                        width: 110,
                        height: 110,
                        alignment: .center
                    )
                    .cornerRadius(50)
            }
        }
    }
}
