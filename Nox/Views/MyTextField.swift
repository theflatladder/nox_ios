//
//  TextField.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct MyTextField: View {
    
    var title: String = ""
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .font(.RubikRegular(14))
                    .foregroundColor(Color.systemGray)
                Spacer()
            }
            TextField("", text: $value)
                .font(.RubikRegular(18))
                .padding(12)
                .keyboardType(keyboardType)
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
