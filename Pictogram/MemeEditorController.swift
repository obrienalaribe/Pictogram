//
//  SharePhotoController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 07/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class MemeEditorController: UIViewController, UITextFieldDelegate{
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }

    let topTextField : UITextField = {
        let tf = UITextField()
        tf.text = "Enter top caption here"
        tf.adjustsFontSizeToFitWidth = true
        tf.clearsOnBeginEditing = true
        tf.tintColor = .white
        tf.addTarget(self, action: #selector(handleEditing(_:)), for: .editingDidBegin)
//        tf.backgroundColor = .red
        return tf
    }()
    
    let bottomTextField : UITextField = {
        let tf = UITextField()
        tf.clearsOnBeginEditing = true
//        tf.backgroundColor = .yellow
        tf.text = "Enter bottom caption here"
        tf.adjustsFontSizeToFitWidth = true
        tf.tintColor = .white
        tf.addTarget(self, action: #selector(handleEditing(_:)), for: .editingDidBegin)
        return tf
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    let saveBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "download"), for: .normal)
        btn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        btn.tintColor = .white
        return btn
    }()
    
    let exportBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "upload"), for: .normal)
        btn.addTarget(self, action: #selector(exportAction), for: .touchUpInside)
        btn.tintColor = .white
        return btn
    }()
    
    var raiseViewForKeyboard = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbar.isHidden = false
        subscribeToKeyboardNotifications()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleMemeUpload))
        
        applyMemeTextAttributes([topTextField, bottomTextField])
        
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(topTextField)
        topTextField.anchor(top: topLayoutGuide.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 100)
        
        view.addSubview(bottomTextField)
        bottomTextField.anchor(top: nil, left: imageView.leftAnchor, bottom: view.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 30, paddingRight: 10, width: 0, height: 100)
        
        setupOptionsToolBar()
    }
    
    fileprivate func setupOptionsToolBar() {
        let optionsToolBar = UIStackView(arrangedSubviews: [saveBtn, exportBtn])
        optionsToolBar.axis = .horizontal
        optionsToolBar.distribution = .fillEqually
        optionsToolBar.spacing = 5
        view.addSubview(optionsToolBar)
        optionsToolBar.anchor(top: nil, left: imageView.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: -10, paddingRight: 0, width: view.frame.width/4, height: 70)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.toolbar.isHidden = true
        unsubscribeToKeyboardNotifications()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func applyMemeTextAttributes(_ textFields: [UITextField]) {
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        let memeTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSStrokeColorAttributeName : UIColor.black,
            NSStrokeWidthAttributeName : -3,
            NSFontAttributeName : UIFont(name: "Impact", size: 50)!,
            ] as [String : Any]
        
        for field in textFields {
            field.delegate = self
            field.defaultTextAttributes = memeTextAttributes
            field.textAlignment = NSTextAlignment.center
        }
    }

    
    func handleEditing(_ sender : UITextField) {
        if sender.isEqual(bottomTextField)  {
            raiseViewForKeyboard = true // fires before keyboardWillShow
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func generateMemedImage() -> UIImage {
        imageView.frame.size = view.frame.size
        imageView.frame.origin = view.frame.origin
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func saveAction() {
        print("saving ...")
    }
    
    func exportAction() {
        print("exporting ...")
    }
    
    func handleMemeUpload() {
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let memeImage = generateMemedImage()
        
        guard let uploadData = UIImageJPEGRepresentation(memeImage, 0.5) else {return}
        
        let filename = NSUUID().uuidString
        
        FIRStorage.storage().reference().child("posts").child(filename).put(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload meme", err)
                return
            }
            
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else {return}
            
            print("Successfully uploaded meme post:", imageUrl)
            
            self.persistImageMetadata(imageURL: imageUrl, image: memeImage)
        }
    }
    
    func persistImageMetadata(imageURL: String, image: UIImage) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        
        let userPostRef = FIRDatabase.database().reference().child("posts").child(uid)
        
        let ref = userPostRef.childByAutoId()
        
        let values : [String : Any] = ["imageUrl": imageURL, "imageWidth" : image.size.width, "imageHeight": image.size.height, "creationDate": Date().timeIntervalSince1970]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                print("Failed to save post to DB")
                return
            }
            
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
       
    }
}



