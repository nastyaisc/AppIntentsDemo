//
//  AddExpenseView.swift
//  AppIntentsDemo
//
//  Created by Анастасия Ищенко on 26.10.2024.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenseStore: ExpenseStore
    @State private var amount: String = ""
    @State private var selectedCategory: Category = .clothes
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Сумма")
            TextField("Введите сумму", text: $amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Категория")
            Picker("Категория", selection: $selectedCategory) {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Spacer()
            
            Button(action: saveExpense) {
                Text("Сохранить")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(amount.isEmpty || Double(amount) == nil)
        }
        .padding(20)
    }
    
    // Функция сохранения траты
    func saveExpense() {
        if let amountValue = Double(amount) {
            expenseStore.addExpense(category: selectedCategory, amount: amountValue)
            presentationMode.wrappedValue.dismiss()
        }
    }
}
