//
//  ViewController.swift
//  Exercise5_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 10/8/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var passData = jsonData()
    @IBOutlet var textDisplay: UITextView!
    @IBOutlet var logo: UIImageView!

    
    func display()
    {
        print(self.passData.about)
        self.textDisplay.text = self.passData.about
        URLSession.shared.dataTask(with: self.passData.logo, completionHandler: {(data, response, error) in

            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.logo.image = UIImage(data: data!)
            }
            
        }).resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = passData.name
        self.display()
        
    }
}

