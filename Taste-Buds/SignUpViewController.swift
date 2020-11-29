//
//  SignUpViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 11/29/20.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var ConfirmEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.registerSubclass()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignup(_ sender: Any) {
        if Password.text == ConfirmPassword.text && Email.text == ConfirmEmail.text {
        let user = PFUser()
        user.username = Username.text
        user.password = Password.text
        user.email = Email.text
        // Other fields can be set just like any other PFObject,
        // like this: user["attribute"] = "its value"
        // If this field does not exists, it will be automatically created

        user.signUpInBackground {
          (succeeded: Bool, error: Error?) -> Void in
          if let error = error {
            let errorString = error.localizedDescription
            print(errorString)
            // Show the errorString somewhere and let the user try again.
          } else {
            self.performSegue(withIdentifier: "onSignUp", sender: nil)          }
        }
        }else if Email.text != ConfirmEmail.text && Password.text != ConfirmPassword.text {
            let alertController = UIAlertController(title: "Sign up failed", message: "Emails and passwords do not match", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if Password.text != ConfirmPassword.text {
            let alertController = UIAlertController(title: "Sign up failed", message: "Passwords do not match", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else if Email.text != ConfirmEmail.text {
            let alertController = UIAlertController(title: "Sign up failed", message: "Emails do not match", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
