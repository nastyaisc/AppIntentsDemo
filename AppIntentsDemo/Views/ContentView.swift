//
//  ContentView.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenseData = ExpenseData()
    @State private var showAddExpense = false
    
    var totalExpense: Double {
        expenseData.expenses.values.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            Text("Сумма расходов:")
                .font(.headline)
                .padding(.top, 100)
            Text("\(totalExpense, specifier: "%.0f")")
                .font(.largeTitle)
                .bold()
                .padding(.top, 5)
                .padding(.bottom, 30)
            
            HStack(spacing: 25) {
                ForEach(expenseData.expenses.sorted(by: {
                    $0.key.rawValue < $1.key.rawValue
                }), id: \.key) { category, amount in
                    VStack {
                        Circle()
                            .fill(category.color)
                            .frame(width: 60, height: 60)
                        Text(category.rawValue)
                            .font(.callout)
                        Text("\(amount, specifier: "%.0f")")
                            .font(.footnote)
                            .foregroundStyle(Color.black.opacity(0.6))
                    }
                }
            }
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
            .padding(.bottom, 30)
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(expenseData: expenseData)
            }
        }
        .background(Color.background)
    }
}

#Preview {
    ContentView()
}
