//
//  SharePhotoController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 07/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    let topTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let bottomTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextView.delegate = self
        
        view.backgroundColor = BrandColours.tertiaryDark
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupTextViewsAndImage()
    }
    
    
    func setupTextViewsAndImage() {
        let topContainerView = UIView()
        view.addSubview(topContainerView)
        topContainerView.backgroundColor = .white
        topContainerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        view.addSubview(topTextView)
        topTextView.anchor(top: topContainerView.topAnchor, left: topContainerView.leftAnchor, bottom: topContainerView.bottomAnchor, right: topContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(imageView)
        imageView.anchor(top: topContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 300)
        
//        let bottomContainerView = UIView()
//        view.addSubview(bottomContainerView)
//        bottomContainerView.backgroundColor = .white
//        bottomContainerView.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
//        
//        view.addSubview(bottomTextView)
//        bottomTextView.anchor(top: bottomContainerView.topAnchor, left: bottomContainerView.leftAnchor, bottom: bottomContainerView.bottomAnchor, right: bottomContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func handleShare() {
        print("sharing photo")
    }
}


extension SharePhotoController : UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print(#function)
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print(#function)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(text)
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let memeText : NSString = textView.text as NSString
        let memeImage = selectedImage?.addText(memeText, atPoint: CGPoint(x: 50, y: 30), textColor:nil, textFont:UIFont.systemFont(ofSize: 200))
        
        print(memeImage)
        imageView.image = memeImage

        print(textView.text)
    }
    
    
}


extension UIImage {
    
    func addText(_ drawText: NSString, atPoint: CGPoint, textColor: UIColor?, textFont: UIFont?) -> UIImage {
        
        // Setup the font specific variables
        var _textColor: UIColor
        if textColor == nil {
            _textColor = UIColor.white
        } else {
            _textColor = textColor!
        }
        
        var _textFont: UIFont
        if textFont == nil {
            _textFont = UIFont.systemFont(ofSize: 16)
        } else {
            _textFont = textFont!
        }
        
        // Setup the image context using the passed image
        UIGraphicsBeginImageContext(size)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: _textFont,
            NSForegroundColorAttributeName: _textColor,
            ] as [String : Any]
        
        // Put the image into a rectangle as large as the original image
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: size.width, height: size.height)
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
        
    }
    
}
