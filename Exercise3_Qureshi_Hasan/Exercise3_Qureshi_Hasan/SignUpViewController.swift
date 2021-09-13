//
//  SignUpViewController.swift
//  Exercise3_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 9/10/2021.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit
protocol UpdateDelegation {
    func newAccount(u: String, p: String)
}
class SignUpViewController: UIViewController {

    var updateDelegatation: UpdateDelegation!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoggedIn2_segue" {
            let welcomeView = segue.destination as! WelcomeViewController
            welcomeView.passedString = username.text!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        let u = username.text!
        let p = password.text!
        let pc = passwordConfirm.text!
        if u.count == 0 || p.count == 0 || pc.count == 0{
            createAlert(title: "Missing Entry!", msg: "Missing User Name, Password, or PasswordConfirm")
        } else if p == pc {
            updateDelegatation.newAccount(u: u, p: p)
            performSegue(withIdentifier: "LoggedIn2_segue", sender: self)
        }
        else{
            createAlert(title: "Password Mismatch!", msg: "Password and Confirm Password does not match")

        }
    }
    
}
