//
//  MyStepper.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct MyStepper: View {
    
    var title: String
    @Binding var value: Int
    @State private var valueInt = 0{
        didSet{
            valueStr = String(valueInt)
        }
    }
    @State private var valueStr = "0"{
        didSet{
            value = Int(valueStr)!
        }
    }
    
    var body: some View {
        HStack{
            MyTextField(title: title, value: $valueStr, keyboardType: .numberPad)
            Stepper("", onIncrement: {
                valueInt += 1
            }, onDecrement: {
                valueInt = max(0, valueInt - 1)
            })
            .padding(.top, 20)
            .padding(.trailing, 20)
            .frame(maxWidth: 150)
            Spacer()
        }
    }
}

#Preview {
    @State var value = 10
    return MyStepper(title: "Max count", value: $value)
}
