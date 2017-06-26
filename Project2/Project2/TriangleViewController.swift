//
//  TriangleViewController.swift
//  Project2
//
//  Created by Janice Chan on 3/11/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class TriangleViewController: UIViewController {
    
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
            let shapeLayer = CAShapeLayer()
            //                shapeLayer.frame = CGRect(x: location.x, y: location.y,
            //                                          width: 30, height: 30)
            let path = CGMutablePath()
            let vertexA: CGPoint = CGPoint(x: location.x - 15, y: location.y + 15)
            let vertexB: CGPoint = CGPoint(x: location.x, y: location.y - 15)
            let vertexC: CGPoint = CGPoint(x: location.x + 15, y: location.y + 15)
            path.addLines(between: [vertexA, vertexB])
            path.addLines(between: [vertexB, vertexC])
            path.addLines(between: [vertexC, vertexA])
            shapeLayer.path = path
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.backgroundColor = UIColor.black.cgColor
            view.layer.addSublayer(shapeLayer)
            
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
