//
//  TextField.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct MyTextField<T>: View {
    
    var title: String = ""
    @Binding var value: T
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .font(.RubikRegular(14))
                    .foregroundColor(Color.systemGray)
                Spacer()
            }
            (T.self == String.self
                 ? TextField("", text: $value as! Binding<String>)
                 : TextField("", value: $value as! Binding<Int>, formatter: NumberFormatter())
            )
            .font(.RubikRegular(18))
            .padding(12)
            .keyboardType(T.self == String.self ? .default : .numberPad)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.systemGray4, lineWidth: 1)
            )
        }
    }
}

#Preview {
    @State var value = "Test Value"
    return MyTextField(title: "Title", value: $value)
}
