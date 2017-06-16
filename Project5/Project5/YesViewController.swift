//
//  YesViewController.swift
//  Project5
//
//  Created by Janice Chan on 4/9/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class YesViewController: UIViewController {
    var liked = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listYes()
        
    }
    
    func listYes(){
        var yesTextView = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: CGFloat(40+10*liked.count)))
        yesTextView.center = CGPoint(x: view.center.x, y: view.center.y)
        yesTextView.textAlignment = .center
        
        var yesText: String = ""
        for yes in liked {
            yesText += yes.name + "\n"
        }
        
        yesTextView.text = yesText
        
        
        view.addSubview(yesTextView)
    }
    
    func setYesList(list:[Person]){
        liked = list
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
