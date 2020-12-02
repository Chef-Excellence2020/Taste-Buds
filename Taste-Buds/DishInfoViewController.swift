//
//  DishInfoViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 12/2/20.
//

import UIKit
import AlamofireImage
import Parse

class DishInfoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var prep: UITextField!
    
    @IBOutlet weak var cook: UITextField!
    
    @IBOutlet weak var servings: UITextField!
    
    @IBOutlet weak var description_dish: UITextField!
    
    @IBOutlet var pass_photo: PFFileObject!
    
    var pass_post = PFObject(className: "Post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.layer.cornerRadius = 60
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNextPress(_ sender: Any) {
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let post = PFObject(className: "Post")
        
        post["photo"] = pass_photo
        post["author"] = PFUser.current()
        post["name"] = name.text
        post["prep"] = prep.text
        post["cook"] = cook.text
        post["servings"] = servings.text
        post["description"] = description_dish.text
        post["ingredients"] = ""
        post["directions"] = ""
        
        pass_post = post
    }
    
    
    @IBAction func onPhotoPress(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery()
   {
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           self.present(imagePicker, animated: true, completion: nil)
       }
       else
       {
           let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 150, height: 150)
        let scaledimage = image.af.imageAspectScaled(toFill: size)
        photo.image = scaledimage
        photo.layer.cornerRadius = 60
        let imageData = photo.image!.pngData()
        let file = PFFileObject(data: imageData!)
        pass_photo = file!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //Pass ingredients to Directions page
        let ingredientsViewController = segue.destination as! IngredientsViewController
        ingredientsViewController.name = name.text!
        ingredientsViewController.prep = prep.text!
        ingredientsViewController.cook = cook.text!
        ingredientsViewController.servings = servings.text!
        ingredientsViewController.photo = photo.image!
    }

}
