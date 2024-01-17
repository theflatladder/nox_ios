//
//  String.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import UIKit

extension String{
    
    static func lz(_ key: String) -> String{
        Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
    
}
