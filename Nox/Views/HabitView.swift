//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import UIKit

class HabitView: UIView{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static func initView(_ habit: Habit) -> HabitView{
        let view: HabitView = getViewFromBundle()
        view.titleLabel.text = habit.title
        return view
    }
    
}

struct Habit{
    var title: String
    var period: Period
    var maxCount: Int
    var currentCount: Int
}

enum Period{
    case Day, Week, Month, Year
}
