//
//  StatsViewController.swift
//  Exercise4_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 9/16/21.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var sum1: UILabel!
    @IBOutlet weak var sum2: UILabel!

    
    var sumDices = [0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sum1.text = String(sumDices[0])
        sum2.text = String(sumDices[1])
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
