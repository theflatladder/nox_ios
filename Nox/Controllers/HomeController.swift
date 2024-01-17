//
//  ViewController.swift
//  Nox
//
//  Created by Александр Новиков on 16.01.2024.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    private var habits = [
        Habit(title: "Habit 1", period: .Day, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 2", period: .Week, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 3", period: .Month, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 1", period: .Day, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 2", period: .Week, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 3", period: .Month, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 1", period: .Day, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 2", period: .Week, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 3", period: .Month, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 1", period: .Day, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 2", period: .Week, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 3", period: .Month, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 1", period: .Day, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 2", period: .Week, maxCount: 100, currentCount: 10),
        Habit(title: "Habit 3", period: .Month, maxCount: 100, currentCount: 10),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: .lz("Add"), style: .plain, target: self, action: #selector(addHabit))
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    @objc func addHabit(){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        HabitView.initView(habits[indexPath.row]).asCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        habits.count
    }
    
}
