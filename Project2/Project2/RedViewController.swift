//
//  RedViewController.swift
//  Project2
//
//  Created by Janice Chan on 3/11/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {
    var redSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            redSquareView = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 30))
            redSquareView.center = location
            redSquareView.backgroundColor = .red
            view.addSubview(redSquareView)
        }
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
