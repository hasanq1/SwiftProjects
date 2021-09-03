//
//  ViewController.swift
//  Demo-Week2
//
//  Created by Shaila Zaman on 9/2/21.
//

import UIKit

class ViewController: UIViewController {
    var nextDay = 1
    var weekArr = [" ","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let weatherImgArr: [UIImage] = [#imageLiteral(resourceName: "weather_2"), #imageLiteral(resourceName: "weather_4"), #imageLiteral(resourceName: "weather_1"), #imageLiteral(resourceName: "weather_3")]
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getRandomNum() -> Int {
        return (Int.random(in: 1...4))
    }

    @IBAction func selectNextDay(_ sender: Any) {
        if inputText.text?.count == 0 {
            nextDay = nextDay%7 + 1
            dayLabel.text = weekArr[nextDay]
            weatherImg.image = weatherImgArr.randomElement()

            
        } else {
            
            if let givenInputnextDay=inputText.text,
                weekArr.contains(givenInputnextDay){
                dayLabel.text = "\(givenInputnextDay)"
                weatherImg.image = weatherImgArr.randomElement()
                
            } else {
                let alert = UIAlertController(title: "Invalid Day", message: "Please enter a valid day e.g Friday", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func selectDay(_ sender: Any) {
        let actionSheetAlert = UIAlertController(title: "Pick a Day", message: "", preferredStyle: .actionSheet)
        
        for nextDay in 1...7 {
            actionSheetAlert.addAction(UIAlertAction(title: "\(weekArr[nextDay])", style: .default, handler: { _ in
                self.dayLabel.text = "\(self.weekArr[nextDay])"
                self.weatherImg.image = self.weatherImgArr.randomElement()
            }))
        }
        
        self.present(actionSheetAlert, animated: true, completion: nil)
        
    }
    
}

