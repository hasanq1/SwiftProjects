//
//  WelcomeViewController.swift
//  Exercise3_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 9/10/2021.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var passedString: String?
    @IBOutlet weak var textOnWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewDidAppear(_ animated: Bool) {
        textOnWelcome.text = "Welcome \(passedString!)!"
    }

    @IBAction func LogOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
