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
}
