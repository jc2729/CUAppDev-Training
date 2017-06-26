//
//  RandomViewController.swift
//  Project2
//
//  Created by Janice Chan on 3/11/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {
    
    var randomSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = randomColor()
        addUIElements()
        // Do any additional setup after loading the view.
    }
    
    func randomColor() -> UIColor{
        let redFloat: CGFloat = CGFloat(arc4random())/pow(2, 31)
        let greenFloat: CGFloat = CGFloat(arc4random())/pow(2, 31)
        let blueFloat: CGFloat = CGFloat(arc4random())/pow(2, 31)
        return UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: 1.0)
    }
    
    func addUIElements(){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            randomSquareView = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 30))
            randomSquareView.center = location
            randomSquareView.backgroundColor = randomColor()
            view.addSubview(randomSquareView)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewControllerModal() {
        dismiss(animated: true, completion: nil)
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
