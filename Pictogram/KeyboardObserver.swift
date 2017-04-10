//
//  KeyboardObserver.swift
//  Pictogram
//
//  Created by mac on 4/8/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

extension MemeEditorController {
    
   
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userinfo = notification.userInfo
        let keyboardSize = userinfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // notification actions
    
    func keyboardWillShow(_ notification: Notification) {
        if raiseViewForKeyboard {
            view.frame.origin.y = -(getKeyboardHeight(notification))
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        raiseViewForKeyboard = false
        view.frame.origin.y = 0
    }
    
    // notification subscriptions
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorController.keyboardWillHide(_:)), name:
            NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillShow)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillHide)
    }
    
}
