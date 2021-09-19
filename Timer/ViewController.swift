//
//  ViewController.swift
//  Timer
//
//  Created by Антон Бобрышев on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    private var timer = Timer()
    private var count = 0
    private var timerCounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            startButton.setTitle("START", for: .normal)
            startButton.setTitleColor(.white, for: .normal)
        } else {
            timerCounting = true
            startButton.setTitle("STOP", for: .normal)
            startButton.setTitleColor(.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimerString(hours: 0, minutes: 0, seconds: 0)
            self.startButton.setTitle("START", for: .normal)
            self.startButton.setTitleColor(.white, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func timerCounter() {
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimerString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    private func makeTimerString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timerString = ""
        
        timerString += String(format: "%02d", hours)
        timerString += " : "
        timerString += String(format: "%02d", minutes)
        timerString += " : "
        timerString += String(format: "%02d", seconds)
        
        return timerString
    }
}

