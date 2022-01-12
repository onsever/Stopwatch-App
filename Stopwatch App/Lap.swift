//
//  Lap.swift
//  Stopwatch App
//
//  Created by Onurcan Sever on 2022-01-12.
//

import Foundation
class Lap {
    var time: String
    var lapCounter: Int
    
    init(time: String, lapCounter: Int) {
        self.time = time
        self.lapCounter = lapCounter
    }
}
