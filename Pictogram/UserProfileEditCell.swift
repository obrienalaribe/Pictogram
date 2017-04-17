//
//  UserProfileEditCell.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 13/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit

class UserProfileEditCell: UITableViewCell, UITextFieldDelegate {

    var fieldName : String? {
        didSet {
            field.text = fieldName
        }
    }
    
    var fieldData : String? {
        didSet{
            textField.text = fieldData
        }
    }
    
    var isTypable : Bool = true {
        didSet {
            print("isTypable  \(isTypable)")
            textField.isUserInteractionEnabled = false
            textField.text?.removeAll()
        }
    }
    
    let field : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.4, alpha: 0.5)
        return label
    }()
    
    let textField : UITextField = {
        let tf = UITextField()
        tf.textColor = BrandColours.label
        tf.tintColor = BrandColours.primary
        tf.textAlignment = .right
        tf.returnKeyType = .done
        return tf
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.delegate = self
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        textField.text?.removeAll()
        
        // Configure the view for the selected state
    }
    
    func setupViews() {
        addSubview(field)
     
        field.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 70, height: 0)
        
      
        addSubview(textField)
        textField.anchor(top: topAnchor, left: field.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 40, width: frame.width * 0.8, height: 0)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}

