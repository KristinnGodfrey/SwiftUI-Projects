//
//  ContentView.swift
//  Challenge Day
//
//  Created by Kristinn Godfrey on 12/08/2020.
//  Copyright © 2020 me.kristinn.godfrey. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var numericInput = ""
    @State private var numericOutput = ""
    var heat = ["Cup", "Pint", "Barrel"]
    @State private var aInput = 0
    @State private var aOutput = 0
    
    var same: Int  {
        if aInput == aOutput {
            return aInput
        }
        return 0
    }
    let lowestDenom: [Int] = [236, 473, 158987]
    
    func getDenoms(lowestDenom: Int) -> Int{
        return lowestDenom
    }
    
    var outcome: Int {
        if aInput == aOutput {
            return 1
        }
        return (lowestDenom[aInput] / lowestDenom[aOutput]) * (Int(numericInput) ?? 0)
    }

    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input: ")){
                    Picker("Amount",selection: $aInput) {
                        ForEach(0 ..< heat.count) {
                            Text(self.heat[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("How many?", text: $numericInput)
                }
                
                Section(header: Text("Output: ")){
                    Picker("Amount",selection: $aOutput) {
                        ForEach(0 ..< heat.count) {
                            Text(self.heat[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())

                    Text("Output: \(outcome)")

                }
            }.navigationBarTitle("Conversion")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
