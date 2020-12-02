//
//  SubmitViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/2/20.
//

import UIKit

class SubmitViewController: UIViewController {

    var ingredientsList = [String]()
    var directionsList = [String]()
    var photo = UIImage()
    var name = String()
    var prep = String()
    var cook = String()
    var servings = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ingredientsList)
        print(directionsList)
        print(name)
        print(prep)
        print(cook)
        print(servings)
        // Do any additional setup after loading the view.
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
