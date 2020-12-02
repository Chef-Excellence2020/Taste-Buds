//
//  SubmitViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/2/20.
//

import UIKit
import Parse
import Toast_Swift

class SubmitViewController: UIViewController {

    var ingredientsList = [String]()
    var directionsList = [String]()
    var photo = UIImage()
    var name = String()
    var prep = String()
    var cook = String()
    var servings = String()
    var description_dish = String()
    var sending = PFObject(className: "Post")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let imageData = photo.pngData()
        let file = PFFileObject(data: imageData!)
        
        let post = PFObject(className: "Post")
        
        post["photo"] = file
        post["author"] = PFUser.current()
        post["name"] = name
        post["prep"] = prep
        post["cook"] = cook
        post["servings"] = servings
        post["description"] = description_dish
        post["ingredients"] = ingredientsList
        post["directions"] = directionsList
        
        post.saveInBackground{ (success, error) in if success{
            print("Saved!")
            self.dismiss(animated: true, completion: nil)
            self.view.makeToast("Bone apple tea!", duration: 3.0, position: .center)
        }else{
            print("Error!")
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
