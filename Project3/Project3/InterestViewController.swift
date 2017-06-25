//
//  InterestViewController.swift
//  Project3
//
//  Created by Janice Chan on 6/17/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

protocol InterestDelegate{
    func updateInterest(oldInterest: String, interest: String)
}

class InterestViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var interestTextField: UITextField!
    var oldInterest: String? = nil
    var interest: String? = nil
    weak var delegate: DetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        interestTextField = UITextField(frame: CGRect(x: 25, y: 100, width: view.frame.width - 50 , height: 30))
        interestTextField.text = oldInterest
        interestTextField.borderStyle = .roundedRect
        interestTextField.clearButtonMode = .whileEditing
        interestTextField.center = view.center
        view.addSubview(interestTextField)
        interestTextField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interestTextField.becomeFirstResponder()
        interestTextField.keyboardAppearance = UIKeyboardAppearance.light
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        interest = interestTextField.text
        delegate?.updateInterest(oldInterest: oldInterest!, interest: interest!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
