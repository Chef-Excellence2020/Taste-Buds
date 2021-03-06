//
//  RecipeDetailsViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/7/20.
//

import UIKit
import Parse

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestions_dict = post["suggestions"] as! NSDictionary
        let cell = tableView.cellForRow(at: indexPath) as! DetailsTableViewCell
        key = cell.recipeDetails.text!
        print(key)
        DetailArray = suggestions_dict[key] as! Array<Any>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredientsList = post["ingredients"] as! Array<Any>
        let directionsList = post["directions"] as! Array<Any>
        return ingredientsList.count + directionsList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientsList = post["ingredients"] as! Array<Any>
        let directionsList = post["directions"] as! Array<Any>
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
            cell.recipeDetails.text = "Ingredients:"
            //wanted color / 255 for some reason :/
            cell.recipeDetails.textColor = UIColor(red: 0.843, green: 0.149, blue: 0.230, alpha: 1.0)
            cell.isUserInteractionEnabled = false
            return cell
        } else if indexPath.row == ingredientsList.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
            cell.recipeDetails.text = "Directions:"
            cell.recipeDetails.textColor = UIColor(red: 0.843, green: 0.149, blue: 0.230, alpha: 1.0)
            cell.isUserInteractionEnabled = false
            return cell
        } else if indexPath.row <= ingredientsList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
            cell.recipeDetails.text = (ingredientsList[indexPath.row - 1] as! String)
            let suggestions_dict = post["suggestions"] as! NSDictionary
            key = cell.recipeDetails.text!
            print(key)
            DetailArray = suggestions_dict[key] as! Array<Any>
            if DetailArray.isEmpty == false {
                cell.egg.isHidden = false
            }
            return cell
        }
        else if indexPath.row < ingredientsList.count + directionsList.count + 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
            cell.recipeDetails.text = (directionsList[indexPath.row - 2 - (ingredientsList.count - 1)] as! String)
            let suggestions_dict = post["suggestions"] as! NSDictionary
            key = cell.recipeDetails.text!
            print(key)
            DetailArray = suggestions_dict[key] as! Array<Any>
            if DetailArray.isEmpty == false {
                cell.egg.isHidden = false
            }
            count += 1
                return cell }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
            cell.recipeDetails.text = ""
            return cell
        }

    }

    @IBOutlet weak var DishPic: UIImageView!
    
    @IBOutlet weak var UserImage: UIImageView!
    
    @IBOutlet weak var DishName: UILabel!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var Servings: UILabel!
    
    @IBOutlet weak var prep: UILabel!
    
    @IBOutlet weak var cook: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalTime: UILabel!
        
    var post = PFObject(className: "post")
    var count = 0
    var key = ""
    var DetailArray = [Any]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        let user = post["author"] as! PFUser
        let imageFile = user["ProfilePic"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        UserImage.af.setImage(withURL: url)
        UserName.text = user.username
        Servings.text = "Servings: " + (post["servings"] as! String)
        prep.text = "Prep Time: " + (post["prep"] as! String) + " minutes"
        cook.text = "Cook Time: " + (post["cook"] as! String) + " minutes"
        totalTime.text = "Total Time: " + String((Int(post["prep"] as! String)! + Int(post["cook"] as! String)!)) + " minutes"
        DishName.text = (post["name"] as! String)
        let imageFile2 = post["photo"] as! PFFileObject
        let urlString2 = imageFile2.url!
        let url2 = URL(string: urlString2)!
        DishPic.af.setImage(withURL: url2)
        // Do any additional setup after loading the view.
        
        //userpic format
        UserImage.layer.cornerRadius = 30
        
        addNavBarImage()
    }
    
    func addNavBarImage() {

            let navController = navigationController!

            let image = UIImage(named: "TastBudsLogo")
            let imageView = UIImageView(image: image)

            let bannerWidth = navController.navigationBar.frame.size.width
            let bannerHeight = navController.navigationBar.frame.size.height

            let bannerX = (bannerWidth / 2 - (image?.size.width)! / 2) / 4
            let bannerY = (bannerHeight / 2 - (image?.size.height)! / 2) / 4

            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit

            navigationItem.titleView = imageView
        }
    
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass ingredients and directions to submit page
        //if suggestions_dict[key] != nil{
            //print(suggestions_dict[key] //as! NSArray)
            //let DetailArray = //suggestions_dict[key] //as! Array<Any>
//if DetailArray.isEmpty {
//            print("you have unwrapped an empty array, congrats")
  //          let suggestionsViewController = segue.destination as! SuggestionsViewController
    //        suggestionsViewController.suggestionsArray = DetailArray
      //      suggestionsViewController.key = key
//        }else{
  //          let suggestionsViewController = segue.destination as! SuggestionsViewController
    //        suggestionsViewController.suggestionsArray = DetailArray
      //      suggestionsViewController.key = key
       // suggestionsViewController.suggestions_dict = post["suggestions"] as! [String : Array<Any>]
        //    suggestionsViewController.objectID = post.objectId!
       // }
      //  } //
    
    //override func performSegue(withIdentifier "StupidAppleNonsense": String, sender: Any?) {
      //  SuggestionsViewController.suggestionsArray = DetailArray
     //   suggestionsViewController.key = key
   // suggestionsViewController.suggestions_dict = post["suggestions"] as! [String : Array<Any>]
     //   suggestionsViewController.objectID = post.objectId!
   // }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "sad") {
                DispatchQueue.main.async {
                    let suggestionsViewController = segue.destination as! SuggestionsViewController
                    suggestionsViewController.suggestionsArray = self.DetailArray
                    suggestionsViewController.key = self.key
                    suggestionsViewController.suggestions_dict = self.post["suggestions"] as! [String : Array<Any>]
                    suggestionsViewController.objectID = self.post.objectId!
                }
          }
    }

    
    //StupidAppleNonsense
    
        //suggestionsViewController.suggestionsArray = ""
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
