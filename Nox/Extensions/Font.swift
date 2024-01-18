//
//  Font.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

extension Font{
    static func RubikRegular(_ size: CGFloat) -> Font{
        Font.custom("Rubik-Regular", size: size)
    }
    static func RubikBlack(_ size: CGFloat) -> Font{
        Font.custom("Rubik-Black", size: size)
    }
    static func RubikBold(_ size: CGFloat) -> Font{
        Font.custom("Rubik-Bold", size: size)
    }
    static func RubikSemiBold(_ size: CGFloat) -> Font{
        Font.custom("Rubik-SemiBold", size: size)
    }
}
