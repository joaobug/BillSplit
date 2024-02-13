//
//  ContentView.swift
//  BillSplit
//
//  Created by Joao Leal on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tips = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tips
        let grandTotal = checkAmount + tipValue
        let perPerson = grandTotal / peopleCount
        
        return perPerson
    }
    
    var body: some View {
        NavigationStack {
            
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0)")
                        }
        
                    }
                }
                
                
                Section("How much tip do you want to leave") {
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
            
                Section("Amount per Person")
                    {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            
                Section("Total Amount") {
 let totalTip = Double(tipPercentage) / 100
                    Text("Total \(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) + \(totalTip * checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))  ")
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                
                
            }.navigationTitle("We Split")
                .toolbar{
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            
        }
    }
}
#Preview {
    ContentView()
}
