//
//  UIView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import UIKit

extension UIView{
    
    static func getViewFromBundle<T>(bundle: Bundle = .main) -> T{
        bundle.loadNibNamed(String(describing: T.self), owner: nil)!.first as! T
    }
    
    func asCell(insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)) -> UITableViewCell{
        translatesAutoresizingMaskIntoConstraints = false
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.addSubview(self)
        cell.contentView.addConstraints([
            cell.contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right),
            cell.contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left),
            cell.contentView.topAnchor.constraint(equalTo: topAnchor, constant: -insets.top),
            cell.contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
        return cell
    }
    
}
