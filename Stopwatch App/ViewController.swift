//
//  ViewController.swift
//  Stopwatch App
//
//  Created by Onurcan Sever on 2022-01-11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var lapButtonLabel: UIButton!
    
    private var currentTime: Int = 0
    private var timer: Timer = Timer()
    private var lapCounter: Int = 0
    private var tapCounter: Int = 0
    private var startTapCounter: Int = 0
    
    private var laps: [Lap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LapCell.self, forCellReuseIdentifier: LapCell.identifier)
        currentTimeLabel.text = getTimeStamp(currentTime: currentTime)
        tableView.backgroundColor = UIColor.systemIndigo
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        startTapCounter += 1
        startButtonLabel.setTitle("Stop", for: .normal)
        lapButtonLabel.setTitle("Lap", for: .normal)
        tapCounter = 0
        
        if (startTapCounter == 2) {
            timer.invalidate()
            startTapCounter = 0
            startButtonLabel.setTitle("Start", for: .normal)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func lapButton(_ sender: UIButton) {
        currentTimeLabel.text = getTimeStamp(currentTime: currentTime)
        lapCounter += 1
        tapCounter += 1
        timer.invalidate()
        startButtonLabel.setTitle("Start", for: .normal)
        lapButtonLabel.setTitle("Reset", for: .normal)
        
        let lap: Lap = Lap(time: getTimeStamp(currentTime: currentTime), lapCounter: self.lapCounter)
        laps.append(lap)
        
        tableView.reloadData()
                
        if (tapCounter == 2) {
            tapCounter = 0
            lapButtonLabel.setTitle("Lap", for: .normal)
            laps.removeAll()
            tableView.reloadData()
            lapCounter = 0
            currentTime = 0
            currentTimeLabel.text = String(0.0)
        }
    
    }
    
    @objc private func startTimer() {
        currentTime += 1
        currentTimeLabel.text = getTimeStamp(currentTime: currentTime)
    }
    
    private func convertSecondsToTime(seconds: Int) -> (Int, Int) {
        return (((seconds % 3600) / 60), (seconds % 3600) % 60)
    }
    
    private func convertTimeToString(minutes: Int, seconds: Int) -> String {
        let strMinutes = String(format: "0%2d", minutes)
        let strSeconds = String(format: "0%2d", seconds)
        
        let strTime = strMinutes + ":" + strSeconds
        
        return strTime
    }
    
    private func getTimeStamp(currentTime: Int) -> String {
        let time = convertSecondsToTime(seconds: currentTime)
        let timeStamp = convertTimeToString(minutes: time.0, seconds: time.1)
        
        return timeStamp
    }

    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LapCell.identifier, for: indexPath) as! LapCell
        
        cell.getData(lap: laps[indexPath.row])
        
        return cell
    }
    
    
}
