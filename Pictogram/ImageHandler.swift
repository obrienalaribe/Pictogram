//
//  ImageHandler.swift
//  Pictogram
//
//  Created by mac on 4/15/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class ImageHandler {
   
    func showImageSourceOptions(viewController: UIViewController){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
  
        imagePickerController.allowsEditing = true
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
                imagePickerController.cameraCaptureMode = .photo
                imagePickerController.modalPresentationStyle = .fullScreen
                viewController.present(imagePickerController,animated: true,completion: nil)
                print("show camera for user")
            } else{
                let alertVC = UIAlertController(
                    title: "No Camera",
                    message: "Sorry, this device has no camera",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil)
                alertVC.addAction(okAction)
                viewController.present(
                    alertVC,
                    animated: true,
                    completion: nil)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (_) in
            
            viewController.present(imagePickerController, animated: true, completion: nil)
            print("show gallery for user")
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
}
