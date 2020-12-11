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
        cell.username.textColor = UIColor(red: 0.843, green: 0.149, blue: 0.230, alpha: 1.0)
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
