//
//  DiscoveryViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/11/20.
//

import UIKit
import Parse
import AlamofireImage

class DiscoveryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = posts[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoveryCollectionViewCell", for: indexPath) as! DiscoveryCollectionViewCell
        let imageFile = post["photo"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.discoveryImage.af.setImage(withURL: url)
        return cell
    }
    
    var posts = [PFObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Post")
        query.includeKeys(["author","ingredients","servings","cook","name","prep","directions","description","photo"])
        query.order(byDescending:"createdAt")
        query.limit = 100
        query.findObjectsInBackground(){ (posts,error) in if posts != nil {
            self.posts = posts!
            self.collectionView.reloadData()
        }else{
            print("boo")
        }
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //layout
        var screenSize: CGRect!
        var screenWidth: CGFloat!
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        addNavBarImage()
        // Do any additional setup after loading the view.
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
        if (segue.identifier == "DiscoveryToDetail") {
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)!
            let post = posts[indexPath.item]
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
