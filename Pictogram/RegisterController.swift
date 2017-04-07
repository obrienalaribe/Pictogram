//
//  ViewController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 05/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterController: UIViewController {

    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePhotoUpload), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = BrandColours.tertiary
        tf.borderStyle = .roundedRect
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = BrandColours.tertiary
        tf.borderStyle = .roundedRect
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = BrandColours.tertiary
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        return tf
    }()
    
    let signUpBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = BrandColours.primaryLight
        btn.layer.cornerRadius = 5
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    let hasAccountBtn: UIButton = {
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign In.", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: BrandColours.primaryDark]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.setTitle("Don't have an account? Sign Up.", for: .normal)
        btn.addTarget(self, action: #selector(handleHaveAccountAction), for: .touchUpInside)
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(plusPhotoButton)
        
        view.addSubview(hasAccountBtn)
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        hasAccountBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        setupInputFields()
    }
    
    
    fileprivate func setupInputFields(){
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpBtn])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    func handleSignUp() {
        // Interactor
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let username = usernameTextField.text, !username.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        // DAO
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Successfully \(user!.email!) created", user?.uid ?? "")

            guard let image = self.plusPhotoButton.imageView?.image else {return}
            
            //compress image by 30%
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            //create unique id for image filename
            let filename = NSUUID().uuidString
        
            //upload image to cloud
            FIRStorage.storage().reference().child("profile_images").child(filename).put(uploadData, metadata: nil, completion: { (metadata, err) in
               
                if let err = err {
                    print("Failed to upload image", err)
                    return
                }
                
                //get image url
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                
                print("Successfully uploaded image", profileImageUrl)
                
                
                guard let uid = user?.uid else {return}
                
                let dictionaryValues = ["username" : username, "profileImageUrl" : profileImageUrl]
                
                let values = [uid: dictionaryValues]
                
                // Save user details
                
                FIRDatabase.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if let err = err {
                        print("Failed to save user", err)
                        return
                    }
                    
                    print("Successfully registered user")
                    
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                    
                    mainTabBarController.setupViewControllers()
                    
                    self.dismiss(animated: true, completion: nil)
                })
                

            })
           
        }
    }
    
    func handleTextInput(){
         let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 &&
         usernameTextField.text?.characters.count ?? 0 > 0 &&
         passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            signUpBtn.isEnabled = true
            signUpBtn.backgroundColor = BrandColours.primary
        } else {
            signUpBtn.isEnabled = false
            signUpBtn.backgroundColor = BrandColours.primaryLight
        }
    }
    
    func handlePhotoUpload() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func handleHaveAccountAction() {
       _ = navigationController?.popViewController(animated: true)
    }
  
}


extension RegisterController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = BrandColours.tertiary.cgColor
        plusPhotoButton.layer.borderWidth = 4
        
        dismiss(animated: true, completion: nil)
    }
    
}

