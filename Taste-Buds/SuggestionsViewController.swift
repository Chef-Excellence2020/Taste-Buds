//
//  SuggestionsViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/7/20.
//

import UIKit
import MessageInputBar
import Parse

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return suggestionsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if suggestionsArray.count + 1 == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddSuggestionCell")!
            return cell
        }
        else if indexPath.row < suggestionsArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionTableViewCell") as! SuggestionTableViewCell
            cell.Suggestions.text = (suggestionsArray[indexPath.row] as! String)
            return cell
        }else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddSuggestionCell")!
        return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showInputBar = true
        becomeFirstResponder()
        ingredientInputBar.inputTextView.becomeFirstResponder()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var suggestionsArray = [Any]()
    var key = ""
    var objectID = ""
    
    let ingredientInputBar = MessageInputBar()
    var showInputBar = false
    var suggestions_dict = [String: Array<Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(suggestions_dict)
        tableView.dataSource = self
        tableView.delegate = self
        print(suggestionsArray)
        ingredientInputBar.inputTextView.placeholder = "+ Suggestion"
        ingredientInputBar.sendButton.title = "Add"
        ingredientInputBar.delegate = self
        
        tableView.keyboardDismissMode = .interactive
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        suggestionsArray.append(ingredientInputBar.inputTextView.text!)
        ingredientInputBar.inputTextView.text = nil
        showInputBar = false
        becomeFirstResponder()
        ingredientInputBar.inputTextView.resignFirstResponder()
        tableView.reloadData()
        //suggestions_dict[key] = suggestionsArray
        //let post = PFObject(className: "Post")
        suggestions_dict[key] = suggestionsArray
        print(suggestions_dict)
        let query = PFQuery(className:"Post")

        query.getObjectInBackground(withId: "uK2JtYoUsr") {
            (object, error) -> Void in
            if error != nil {
                print("error")
            } else {
                object?["suggestions"] = self.suggestions_dict
                object!.saveInBackground()
                print("saved?")
            }
        }
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
