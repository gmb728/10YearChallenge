//
//  ChallengeViewController.swift
//  10YearChallenge
//
//  Created by Chang Sophia on 2/5/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit
import AVFoundation


class ChallengeViewController: UIViewController {
    var timer: Timer?
    var autoPlay = 0
    var timeImageYear = 2009
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var imageB: UIImageView!
  
    @IBOutlet weak var autoPlayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if timer != nil {
            timer?.invalidate()
        }
    }
    @IBAction func autoPlayAciton(_ sender: UIButton) {
        if autoPlay == 0{
        autoPlay = 1
        timeImageYear = Int(mySlider.value)
            autoPlayButton.setTitle("Stop", for: .normal)
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
        }
        
        else{
            autoPlay = 0
            autoPlayButton.setTitle("Auto", for: .normal)
            if timer != nil {
                timer?.invalidate()
            }
        }
    }
    
    @objc func timeFunc() {
    yearLabel.text = "\(timeImageYear)"
    mySlider.value = Float(timeImageYear)
        imageB.image = UIImage(named: "\(timeImageYear).jpg")
        imageA.image = UIImage(named: "okinawa")
        if timeImageYear < 2019 {
            timeImageYear += 1
        }
        else{
            timeImageYear = 2009
        }
    }
    override func viewWillAppear(_ animated: Bool){
        let time = DateFormatter()
        time.dateFormat = "yyyy"
        let y = time.string(from: myDatePicker.date)
        yearLabel.text = String(y)
    }
    
    @IBAction func mySliderAction(_ sender: UISlider) {
        sender.value = round(sender.value)
        let year = Int(sender.value)
        yearLabel.text = String(year)
        imageB.image = UIImage(named: "\(year).jpg")
        imageA.image = UIImage(named: "okinawa")
        
        let newDate = DateComponents(calendar: Calendar.current,  year: year).date
       myDatePicker.date = newDate!
    }
    
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let dateValue = DateFormatter()
        dateValue.dateFormat = "YYYY"
        let y = dateValue.string(from: myDatePicker.date)
        imageB.image = UIImage(named: "\(String(y)).jpg")
        imageA.image = UIImage(named: "okinawa")
        yearLabel.text = String(y)  }
    
    }







