//
//  ViewController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 05/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 1, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 1, alpha: 0.03)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 1, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let signUpBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = BrandColours.primary
        btn.layer.cornerRadius = 5
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(plusPhotoButton)
       
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
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
        
        
        guard let email = emailTextField.text, !email.isEmpty else { return }
        print(email.isEmpty)
        guard let username = usernameTextField.text, !username.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("\(user!.email!) created")
        
        }
    }
    
    func handleTextInput(){
      
        
        if isFormValid {
            
        }
        signUpBtn.backgroundColor = .red
    }
    
  
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
