//
//  RegisterController.swift
//  2340
//
//  Created by Chengkai Yang on 11/28/18.
//  Copyright © 2018 Chengkai Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        if let email = emailField.text, let pass = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "register", sender: self)
                }

            }
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
