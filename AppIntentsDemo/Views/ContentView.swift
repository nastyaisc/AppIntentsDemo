//
//  ContentView.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @StateObject private var expenseStore = ExpenseStore.shared
    @State private var showAddExpense = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Очистить", action: expenseStore.clearStorage)
                    .padding(.trailing, 20)
                    .foregroundStyle(.black.opacity(0.6))
            }
            Text("Сумма расходов:")
                .font(.headline)
                .padding(.top, 100)
            Text("\(expenseStore.totalExpense, specifier: "%.0fр.")")
                .font(.largeTitle)
                .bold()
                .padding(.top, 5)
                .padding(.bottom, 30)
            
            HStack(spacing: 25) {
                ForEach(expenseStore.chartExpensesData, id: \.category.rawValue) { expense in
                    VStack {
                        Circle()
                            .fill(expense.category.color)
                            .frame(width: 60, height: 60)
                        Text(expense.category.rawValue)
                            .font(.callout)
                        Text("\(expense.value, specifier: "%.0f")")
                            .font(.footnote)
                            .foregroundStyle(Color.black.opacity(0.6))
                    }
                }
            }
            .padding(.bottom, 20)
            
            ChartView(
                expensesModel: expenseStore.chartExpensesData,
                totalExpense: expenseStore.totalExpense,
                showTotalExpense: true
            )
            .frame(height: 200)
            .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                showAddExpense.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .cornerRadius(30)
                    .addBorder(
                        Color.black.opacity(0.2),
                        width: 1,
                        cornerRadius: 30
                    )
            }
            .foregroundStyle(Color.white)
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(expenseStore: expenseStore)
            }
            
            Button(intent: AddExpenseIntent(category: .other, amount: 500)) {
                Text("Добавить трату 500р. в категорию: \(Category.other.rawValue)")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding(10)
            }
            .addBorder(
                Color.black.opacity(0.2),
                width: 1,
                cornerRadius: 30
            )
            .foregroundStyle(Color.white)
            .padding(20)
        }
        .background(Color.background)
    }
}


#Preview {
    ContentView()
}


