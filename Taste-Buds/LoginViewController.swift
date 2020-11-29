//
//  LoginViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 11/29/20.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Username.becomeFirstResponder()
        PFUser.registerSubclass()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground:Username.text ?? "", password:Password.text ?? "") {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
            // Do stuff after successful login.
            self.performSegue(withIdentifier: "onLogin", sender: nil)
          } else {
            // The login failed. Check error to see why.
            print(error as Any)
            let alertController = UIAlertController(title: "Sign in failed", message: "Username/password do not match", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
