//
//  DirectionsViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/1/20.
//

import UIKit
import MessageInputBar
import Parse

class DirectionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directionsList.count + 1
    }
    
    @IBOutlet weak var IngredientsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if directionsList.count + 1 == 1 {
            let cell = TableView.dequeueReusableCell(withIdentifier: "AddDirectionCell")!
            return cell
        }
        else if indexPath.row < directionsList.count {
            let cell = TableView.dequeueReusableCell(withIdentifier: "PostDirectionCell") as! PostDirectionTableViewCell
            cell.Direction.text = directionsList[indexPath.row]
            return cell
        }else {
        let cell = TableView.dequeueReusableCell(withIdentifier: "AddDirectionCell")!
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showInputBar = true
        becomeFirstResponder()
        ingredientInputBar.inputTextView.becomeFirstResponder()
        let ingredient = PFObject(className: "Ingredients")
        ingredient["text"] = ingredientInputBar.inputTextView.text
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        directionsList.append(ingredientInputBar.inputTextView.text)
        ingredientInputBar.inputTextView.text = nil
        showInputBar = false
        becomeFirstResponder()
        ingredientInputBar.inputTextView.resignFirstResponder()
        TableView.reloadData()
    }

    @IBOutlet weak var TableView: UITableView!
    let ingredientInputBar = MessageInputBar()
    var showInputBar = false
    var ingredientsList = [String]()
    var directionsList = [String]()
    var photo = UIImage()
    var name = String()
    var prep = String()
    var cook = String()
    var servings = String()
    var description_dish = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        ingredientInputBar.inputTextView.placeholder = "Direction"
        ingredientInputBar.sendButton.title = "Add"
        ingredientInputBar.delegate = self
        
        TableView.keyboardDismissMode = .interactive

        // Do any additional setup after loading the view.
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func keyboardWillBeHidden(note: Notification){
        ingredientInputBar.inputTextView.text = nil
        showInputBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return ingredientInputBar
    }
    override var canBecomeFirstResponder: Bool{
        return showInputBar
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //Pass ingredients and directions to submit page
        let SubmitViewController = segue.destination as! SubmitViewController
        SubmitViewController.ingredientsList = ingredientsList
        SubmitViewController.directionsList = directionsList
        SubmitViewController.name = name
        SubmitViewController.prep = prep
        SubmitViewController.cook = cook
        SubmitViewController.servings = servings
        SubmitViewController.photo = photo
        SubmitViewController.description_dish = description_dish
        

    }

}
