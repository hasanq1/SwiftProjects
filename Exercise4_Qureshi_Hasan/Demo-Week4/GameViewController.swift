//
//  GameViewController.swift
//  Exercise4_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 9/16/21.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!

    
    var sumDices = [0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let statsTab = self.tabBarController?.children[1] as! StatsViewController
        statsTab.sumDices = sumDices
    }
    
    @IBAction func shuffle(_ sender: Any) {
        let num1 = Int.random(in: 2..<9)
        let num2 = Int.random(in: 2..<9)
        
        img1.image = UIImage(named: "\(num1).png")
        img2.image = UIImage(named: "\(num2).png")
        
//        sumDices[0] += num1
//        sumDices[1] += num2
        //var num1: Double = 0, num2: Double = 0;
        
        if (img1.image == img2.image){
            sumDices[0] += 1;
        }
        else{
            sumDices[1] += 1;
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
