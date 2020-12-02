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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "AddIngredientCell")!
        return cell
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
    }

    @IBOutlet weak var TableView: UITableView!
    let ingredientInputBar = MessageInputBar()
    var showInputBar = false
    var ingredientsList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
