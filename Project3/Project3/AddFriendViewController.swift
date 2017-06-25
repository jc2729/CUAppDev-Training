//
//  AddFriendViewController.swift
//  Project3
//
//  Created by Janice Chan on 6/24/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

protocol AddFriendDelegate {
    func addNewFriend(name: String, age: Int, interest: String)
}

class AddFriendViewController: UIViewController, UITextFieldDelegate {
    weak var nameField: UITextField!
    weak var ageField: UITextField!
    weak var interestField: UITextField!
    weak var delegate: FeedViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let nameLabel = UITextView(frame: CGRect(x: 30, y: 35, width: 70, height: 100))
        nameLabel.text = "Name:"
        nameLabel.font = UIFont(name: (nameLabel.font?.fontName)!, size: 15)
        nameLabel.isEditable = false
        view.addSubview(nameLabel)
        
        nameField = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 30))
        nameField.isHidden = false
        nameField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(nameField)
        
        
        
        let ageTextView = UITextView(frame: CGRect(x: 30, y: 150, width: 70, height: 50))
        ageTextView.text = "Age:"
        ageTextView.font = UIFont(name: (ageTextView.font?.fontName)!, size: 15)
        ageTextView.isEditable = false
        view.addSubview(ageTextView)
        
        ageField = UITextField(frame: CGRect(x: 100, y: 150, width: 200, height: 30))
        ageField.isHidden = false
        ageField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(ageField)
        
        
        let interestTextView = UITextView(frame: CGRect(x: 30, y: 200, width: 70, height: 50))
        interestTextView.text = "Interest:"
        interestTextView.font = UIFont(name: (interestTextView.font?.fontName)!, size: 15)
        interestTextView.isEditable = false
        view.addSubview(interestTextView)
        
        interestField = UITextField(frame: CGRect(x: 100, y: 200, width: 200, height: 30))
        interestField.isHidden = false
        interestField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(interestField)
        
        let button = UIButton(frame: CGRect(x: view.center.x, y: 250, width: 120, height: 30))
        button.backgroundColor = UIColor.white
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Add Friend", for: UIControlState.normal)
        button.addTarget(self, action: #selector(addFriendButton), for: .touchUpInside)
        button.center = CGPoint(x: view.center.x, y: 330)
        view.addSubview(button)
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false;
    }
    
    //update the detail view controller with the edited interest
    func addFriendButton() {        
        if let unwrappedName = nameField.text, let unwrappedAge = ageField.text, let unwrappedInterest = interestField.text {
            if let unwrappedAgeInt = Int(unwrappedAge) {
                delegate?.addNewFriend(name: unwrappedName, age: unwrappedAgeInt, interest: unwrappedInterest)
            }
        }
        
    }
    
}
