//
//  FeedViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/2/20.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let user = post["author"] as! PFUser
        cell.username.text = user.username
        cell.dishName.text = (post["name"] as! String)
        cell.dishDescription.text = (post["description"] as! String)
        let imageFile = post["photo"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.DishPic.af.setImage(withURL: url)
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Post")
        query.includeKeys(["author","ingredients","servings","cook","name","prep","directions","description","photo"])
        query.order(byDescending:"createdAt")
        query.limit = 100
        query.findObjectsInBackground(){ (posts,error) in if posts != nil {
            self.posts = posts!
            self.tableView.reloadData()
        }else{
            print("boo")
        }
            
        }
    }
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //fixes bug where trying to create a recipe from would crash
        //This segue can only be sent to the recipe details viewcontroller
        if (segue.identifier == "toDetail") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let post = posts[indexPath.row]
            let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
            recipeDetailsViewController.post = post
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
