//
//  ContentView.swift
//  WeSplit
//
//  Created by Carlos Tiago on 14/02/20.
//  Copyright © 2020 Carlos Tiago. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: [Double] {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        let amountPerPersonWithoutTips = orderAmount / peopleCount
        let tipPerPerson = tipValue / peopleCount
        let values = [amountPerPerson, tipValue, amountPerPerson,amountPerPersonWithoutTips,tipPerPerson]
        return values
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("How much is the bill?")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("How many people will share?")) {
                    TextField("Number of people", value: $numberOfPeople,formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tips you are leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Amount per person")) {
                    Text("$\(totalPerPerson[0], specifier: "%.2f")")
                }
                Section (header: Text("Descriptive values")) {
                    Text("Total per person without tip $\(totalPerPerson[3], specifier: "%.2f")")
                    Text("Collective tip $\(totalPerPerson[1], specifier: "%.2f")")
                    Text("Individual tip $\(totalPerPerson[4], specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
