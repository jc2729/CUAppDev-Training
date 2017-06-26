//
//  DetailViewController.swift
//  Project4
//
//  Created by Janice Chan on 3/27/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

protocol DetailViewDelegate {
    func finishedEditingContact(row: Int, updatedContact: Contact)
}

class DetailViewController: UIViewController {
    
    var profileImageView: UIImageView!
    var nameTextField: UITextField!
    var numberTextField: UITextField!
    var emailTextView: UITextView!
    var saveButton: UIButton!
    
    var contact: Contact!
    var contactNumber: Int!
    var delegate: FeedViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tappedEditBarButton))
        self.navigationItem.setRightBarButton(editBarButton, animated: true)
        navigationController?.navigationItem.rightBarButtonItem = editBarButton
        
        view.backgroundColor = .white
        
        profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4.0, height: view.frame.width / 4.0))
        profileImageView.center = CGPoint(x: view.center.x, y: profileImageView.frame.height / 2.0 + 100)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2.0
        profileImageView.clipsToBounds = true
        profileImageView.image = contact.image
        profileImageView.contentMode = .scaleAspectFill
        
        nameTextField = UITextField(frame: CGRect(x: 0, y: 10 + profileImageView.frame.height + profileImageView.frame.origin.y, width: view.frame.width / 2.0, height: 30))
        nameTextField.center = CGPoint(x: view.center.x, y: nameTextField.center.y)
        nameTextField.textAlignment = .center
        nameTextField.text = contact.name
        nameTextField.isUserInteractionEnabled = false
        
        numberTextField = UITextField(frame: CGRect(x: 0, y: nameTextField.frame.height + nameTextField.frame.origin.y + 10, width: view.frame.width / 2.0, height: 30))
        numberTextField.center = CGPoint(x: view.center.x, y: numberTextField.center.y)
        numberTextField.textAlignment = .center
        numberTextField.text = contact.number
        numberTextField.isUserInteractionEnabled = false

        emailTextView = UITextView(frame: CGRect(x: 0, y: numberTextField.frame.height + numberTextField.frame.origin.y + 10, width: view.frame.width, height: CGFloat(40+10*contact.emails.count)))
        emailTextView.center = CGPoint(x: view.center.x, y: emailTextView.center.y)
        emailTextView.textAlignment = .center
        emailTextView.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        var emailDisplay: String = ""
        for email in contact.emails{
            emailDisplay += email + "\n"
        }
        emailTextView.text = emailDisplay
        emailTextView.isEditable = false
        
        
        view.addSubview(profileImageView)
        view.addSubview(nameTextField)
        view.addSubview(numberTextField)
        view.addSubview(emailTextView)
        

    }
    
    //edit contact
    func tappedEditBarButton() {

        nameTextField.isUserInteractionEnabled = true
        numberTextField.isUserInteractionEnabled = true
        emailTextView.isEditable = true
        nameTextField.borderStyle = .roundedRect
        numberTextField.borderStyle = .roundedRect
        
        let borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        emailTextView.layer.borderColor = borderColor
        emailTextView.layer.borderWidth = 0.5
        emailTextView.layer.cornerRadius = 5
        
        saveButton = UIButton(frame: CGRect(x: 0, y: emailTextView.frame.height + emailTextView.frame.origin.y + 10 , width: 300, height: 30))
        saveButton.backgroundColor = UIColor.white
        saveButton.center = CGPoint(x: view.center.x, y: saveButton.center.y)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.setTitle("Save Edits", for: UIControlState.normal)
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        view.addSubview(saveButton)
        
    }
    
    //save changes and go back to contacts list
    func tappedSaveButton() {
        nameTextField.isUserInteractionEnabled = false
        numberTextField.isUserInteractionEnabled = false
        emailTextView.isEditable = false
        nameTextField.borderStyle = .none
        numberTextField.borderStyle = .none
        emailTextView.layer.borderColor = UIColor.white.cgColor
        if let unwrappedName = nameTextField.text, let unwrappedNumber = numberTextField.text, let unwrappedEmails = emailTextView.text {
            contact.name = unwrappedName
            contact.number = unwrappedNumber
            contact.emails = unwrappedEmails.components(separatedBy: .whitespacesAndNewlines)
            contact.emails.removeLast()
            delegate?.finishedEditingContact(row: contactNumber, updatedContact: contact)
        }
        dismissDetailViewController()
    }
    
    func dismissDetailViewController(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
