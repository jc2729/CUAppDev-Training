//
//  BlueViewController.swift
//  Project2
//
//  Created by Janice Chan on 3/11/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {
    var blueSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addUIElements()
        // Do any additional setup after loading the view.
    }
    func addUIElements(){
        let backButton = UIButton(frame: CGRect(x: 0 , y: 30, width: view.frame.width, height: 30))
        backButton.setTitleColor(.blue, for: .normal)
        backButton.setTitle("Back", for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(dismissViewControllerModal), for: .touchUpInside)
        view.addSubview(backButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            blueSquareView = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 30))
            blueSquareView.center = location
            blueSquareView.backgroundColor = .blue
            view.addSubview(blueSquareView)
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
