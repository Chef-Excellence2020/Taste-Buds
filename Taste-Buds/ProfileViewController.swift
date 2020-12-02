//
//  ProfileViewController.swift
//  Taste-Buds
//
//  Created by Justin Ralph on 11/29/20.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var ProfilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        username.text = user?.username
        //set profile pic from database
        let imageFile = user!["ProfilePic"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        ProfilePic.af.setImage(withURL: url)
        ProfilePic.layer.cornerRadius = 75
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onChangeProfilePic(_ sender: Any) {
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
        ProfilePic.image = scaledimage
        
        //update profile pic on parse
        let user = PFUser.current()
        let imageData = ProfilePic.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user?.setObject(file as Any, forKey: "ProfilePic")
        ProfilePic.layer.cornerRadius = 75
        user?.saveInBackground{ (success, error) in if success{
            print("Saved!")
            self.dismiss(animated: true, completion: nil)
        }else{
            print("Error!")
        }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = loginViewController
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
