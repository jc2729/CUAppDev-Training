//
//  ViewController.swift
//  Project1
//
//  Created by Janice Chan on 3/2/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class Student{
    var name: String
    var major: String
    var gpa: Double
    var year: Int
    init(name: String, year: Int, major: String, gpa: Double){
        self.name = name
        self.major = major
        self.year = year
        self.gpa = gpa
    }
    func description() -> String{
        return "\(name) is majoring in \(major) with a \(gpa)"
    }
    
    
}

class ViewController: UIViewController {
    
    var studentsArray: [Student] = [Student]()
    var nameField: UITextField!
    var yearField: UITextField!
    var majorField: UITextField!
    var gpaField: UITextField!
    var studentInfoDisplay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        addUIElements()
    }
    
    func addUIElements(){
        let nameTextView = UITextView(frame: CGRect(x: 30, y: 50, width: 70, height: 50))
        nameTextView.text = "Name:"
        nameTextView.font = UIFont(name: (nameTextView.font?.fontName)!, size: 15)
        nameTextView.isEditable = false
        view.addSubview(nameTextView)
        
        nameField = UITextField(frame: CGRect(x: 100, y: 50, width: 230, height: 30))
        nameField.isHidden = false
        nameField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(nameField)
        
        let yearTextView = UITextView(frame: CGRect(x: 30, y: 100, width: 70, height: 50))
        yearTextView.text = "Year:"
        yearTextView.font = UIFont(name: (yearTextView.font?.fontName)!, size: 15)
        yearTextView.isEditable = false
        view.addSubview(yearTextView)
        
        yearField = UITextField(frame: CGRect(x: 100, y: 100, width: 230, height: 30))
        yearField.isHidden = false
        yearField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(yearField)
        
        let majorTextView = UITextView(frame: CGRect(x: 30, y: 150, width: 70, height: 50))
        majorTextView.text = "Major:"
        majorTextView.font = UIFont(name: (majorTextView.font?.fontName)!, size: 15)
        majorTextView.isEditable = false
        view.addSubview(majorTextView)
        
        majorField = UITextField(frame: CGRect(x: 100, y: 150, width: 230, height: 30))
        majorField.isHidden = false
        majorField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(majorField)
        
        let gpaTextView = UITextView(frame: CGRect(x: 30, y: 200, width: 70, height: 50))
        gpaTextView.text = "GPA:"
        gpaTextView.font = UIFont(name: (gpaTextView.font?.fontName)!, size: 15)
        gpaTextView.isEditable = false
        view.addSubview(gpaTextView)
        
        gpaField = UITextField(frame: CGRect(x: 100, y: 200, width: 230, height: 30))
        gpaField.isHidden = false
        gpaField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(gpaField)
        
        let button = UIButton(frame: CGRect(x: view.center.x, y: 250, width: 120, height: 30))
        button.backgroundColor = UIColor.white
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Add Student", for: UIControlState.normal)
        button.addTarget(self, action: #selector(addStudentButton), for: .touchUpInside)
        button.center = CGPoint(x: view.center.x, y: 280)
        view.addSubview(button)
        
        let studentInfoHeader = UITextView(frame: CGRect(x:  view.center.x , y: 600, width: 300, height: 50))
        studentInfoHeader.text = "Student Information"
        studentInfoHeader.font = UIFont(name: (studentInfoHeader.font?.fontName)!, size: 15)
        studentInfoHeader.textAlignment = .center
        studentInfoHeader.center = CGPoint(x: view.center.x, y: 350)
        studentInfoHeader.isEditable = false
        view.addSubview(studentInfoHeader)
        
        studentInfoDisplay = UITextView(frame: CGRect(x: view.center.x, y: 350, width: 300, height: 300))
        studentInfoDisplay.isEditable = false
        studentInfoDisplay.textAlignment = .center
        studentInfoDisplay.center = CGPoint(x: view.center.x, y: 350 + 150)
        
        view.addSubview(studentInfoDisplay)
        
    }
    
    func addStudentButton(){
        if let unwrappedName = nameField.text, let unwrappedYearString = yearField.text, let unwrappedMajor = majorField.text, let unwrappedGPAString = gpaField.text {
            if let unwrappedYearInt = Int(unwrappedYearString), let unwrappedGPADouble = Double(unwrappedGPAString) {
                if unwrappedGPADouble >= 0.0 && unwrappedGPADouble <= 4.33 {
                    let newStudent = Student(name: unwrappedName, year: unwrappedYearInt, major: unwrappedMajor, gpa: unwrappedGPADouble)
                    studentsArray.append(newStudent)
                }
            }
        }
        var displayText: String = ""
        for student in studentsArray {
            displayText += student.description() + "\n"
        }
        
        studentInfoDisplay.text = displayText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recrea ted.
    }
    
    
    
}

