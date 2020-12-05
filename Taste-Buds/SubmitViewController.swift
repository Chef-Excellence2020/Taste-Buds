//
//  SubmitViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/2/20.
//

import UIKit
import Parse
import Toast_Swift

class SubmitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count + directionsList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell") as! PreviewTableViewCell
            cell.recipeDetails.text = "Ingredients:"
            return cell
        } else if indexPath.row == ingredientsList.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell") as! PreviewTableViewCell
            cell.recipeDetails.text = "Directions:"
            return cell
        } else if indexPath.row <= ingredientsList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell") as! PreviewTableViewCell
            cell.recipeDetails.text = ingredientsList[indexPath.row - 1]
            return cell
        }
        else if indexPath.row <= ingredientsList.count + directionsList.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell") as! PreviewTableViewCell
            cell.recipeDetails.text = directionsList[count] 
            count += 1
                return cell }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell") as! PreviewTableViewCell
            cell.recipeDetails.text = ""
            return cell
        }
    }
    

    var ingredientsList = [String]()
    var directionsList = [String]()
    var photo = UIImage()
    var name = String()
    var prep = String()
    var cook = String()
    var servings = String()
    var description_dish = String()
    var sending = PFObject(className: "Post")
    var count = 0

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var PreviewPic: UIImageView!
    
    @IBOutlet weak var PreviewName: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var PreviewServings: UILabel!
    
    @IBOutlet weak var PreviewPrep: UILabel!
    
    @IBOutlet weak var PreviewCook: UILabel!
    
    @IBOutlet weak var PreviewTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        let user = PFUser.current()
        let imageFile = user!["ProfilePic"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        userImage.af.setImage(withURL: url)
        userName.text = user?.username
        PreviewServings.text = "Servings: " + servings
        PreviewPrep.text = "Prep Time: " + prep
        PreviewCook.text = "Cook Time: " + cook
        PreviewTotal.text = "Total Time: " + String((Int(prep)! + Int(cook)!))
        PreviewName.text = name
        PreviewPic.image = photo
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
