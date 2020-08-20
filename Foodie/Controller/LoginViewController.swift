//
//  LoginViewController.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 20/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginAction(_ sender: Any) {
        if phoneField.text?.count == 10 {

            let shopsNC = self.storyboard?.instantiateViewController(withIdentifier: "ShopsNav") as! UINavigationController
            self.present(shopsNC, animated: true, completion: nil)
        } else {
            //Toast
            self.showCustomToast(message: "Please enter a valid mobile number", backColor: .red)
        }

    }
}
