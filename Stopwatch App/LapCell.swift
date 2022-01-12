//
//  LapCell.swift
//  Stopwatch App
//
//  Created by Onurcan Sever on 2022-01-11.
//

import UIKit

class LapCell: UITableViewCell {
    
    public static let identifier = "LapCell"
    private var timeLabel = UILabel()
    private var lapLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(timeLabel)
        addSubview(lapLabel)
        
        configureLayouts()
        backgroundColor = .systemIndigo
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureLayouts() {
        timeLabel.numberOfLines = 0
        lapLabel.numberOfLines = 0
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        lapLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            lapLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            lapLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            lapLabel.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    public func getData(lap: Lap) {
        timeLabel.text = String(lap.time)
        lapLabel.text = "Lap \(lap.lapCounter)"
    }
    
}
