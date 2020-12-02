//
//  IngredientsViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/1/20.
//

import UIKit
import MessageInputBar
import Parse

class IngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count + 1
    }
    
    @IBOutlet weak var IngredientsTableView: UITableView!
    
    var directionsList = String()
    
    var photo = UIImage()
    
    var name = String()
    
    var prep = String()
    
    var cook = String()
    
    var servings = String()
    
    var description_dish = String()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(ingredientsList.count)
        print(ingredientsList)
        if ingredientsList.count + 1 == 1 {
            let cell = TableView.dequeueReusableCell(withIdentifier: "AddIngredientCell")!
            return cell
        }
        else if indexPath.row < ingredientsList.count {
            let cell = TableView.dequeueReusableCell(withIdentifier: "PostedIngredientTableViewCell") as! PostedIngredientTableViewCell
            cell.ingredient.text = ingredientsList[indexPath.row]
            return cell
        }else {
        let cell = TableView.dequeueReusableCell(withIdentifier: "AddIngredientCell")!
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
        ingredientsList.append(ingredientInputBar.inputTextView.text)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        print(name)
        print(prep)
        print(cook)
        print(servings)
        ingredientInputBar.inputTextView.placeholder = "Ingredient + amount"
        ingredientInputBar.sendButton.title = "Add"
        ingredientInputBar.delegate = self
        
        TableView.keyboardDismissMode = .interactive

        // Do any additional setup after loading the view.
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
        //Pass ingredients to Directions page
        let DirectionsViewController = segue.destination as! DirectionsViewController
        DirectionsViewController.ingredientsList = ingredientsList
        DirectionsViewController.name = name
        DirectionsViewController.prep = prep
        DirectionsViewController.cook = cook
        DirectionsViewController.servings = servings
        DirectionsViewController.photo = photo
        DirectionsViewController.description_dish = description_dish
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
