//
//  ViewController.swift
//  Exercise3_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 9/10/2021.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UpdateDelegation {
    var userNamePassDictionary = ["admin": "admin", "super admin": "SuperPass"]
    
    func newAccount(u: String, p: String) {
        userNamePassDictionary[u] = p
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signup_segue" {
            let signupView = segue.destination as! SignUpViewController
            signupView.updateDelegatation = self
        }
        if segue.identifier == "welcome_segue" {
            let welcomeView = segue.destination as! WelcomeViewController
            welcomeView.passedString = username.text!
        }
    }
    
    
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func LogIn(_ sender: Any) {
        let u = username.text!
        let p = password.text!
        
        if u.count == 0 ||
            p.count == 0 {
            createAlert(title: "Missing Entry!", msg: "Missing User Name or Password")
        } else if userNamePassDictionary[u] != nil,
             userNamePassDictionary[u] == p {
                performSegue(withIdentifier: "welcome_segue", sender: self)
        }else {
            createAlert(title: "Invalid Entry!", msg: "Combination of User Name and Password is not valid")
        }

    }
    
    @IBAction func SignUp(_ sender: Any) {
        performSegue(withIdentifier: "signup_segue", sender: self)
    }
}

