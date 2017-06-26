//
//  ShapeViewController.swift
//  Project2
//
//  Created by Janice Chan on 6/25/17.
//
//

import UIKit

class ShapeViewController: UIViewController {
    var shapeType: String!
    var shapeView: UIView!
    
    //sets up the background
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if shapeType == ("Random"){
            view.backgroundColor = randomColor()
        }
        else if shapeType == ("Blue"){
            let backButton = UIButton(frame: CGRect(x: 0 , y: 25, width: view.frame.width, height: 30))
            backButton.setTitleColor(.blue, for: .normal)
            backButton.setTitle("Back", for: UIControlState.normal)
            backButton.addTarget(self, action: #selector(dismissViewControllerModal), for: .touchUpInside)
            view.addSubview(backButton)

        }
        addUIElements()
    }

    init(shape: String) {
        shapeType = shape
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIElements(){
        let hideButton = UIButton(frame: CGRect(x: 0 , y: view.frame.height - 30, width: view.frame.width / 2, height: 30))
        hideButton.setTitleColor(.blue, for: .normal)
        hideButton.setTitle("Hide All", for: UIControlState.normal)
        hideButton.addTarget(self, action: #selector(hideAll), for: .touchUpInside)
        view.addSubview(hideButton)
        
        let showButton = UIButton(frame: CGRect(x: view.frame.width/2 , y: view.frame.height - 30, width: view.frame.width / 2, height: 30))
        showButton.setTitleColor(.blue, for: .normal)
        showButton.setTitle("Show All", for: UIControlState.normal)
        showButton.addTarget(self, action: #selector(showAll), for: .touchUpInside)
        view.addSubview(showButton)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //adds the specified shape depending on the arena
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch shapeType {
        case "Triangle":
            if let location = touches.first?.location(in: view) {
                let shapeLayer = CAShapeLayer()
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
        case "Red":
            if let location = touches.first?.location(in: view) {
                shapeView = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 30))
                shapeView.center = location
                shapeView.backgroundColor = .red
                view.addSubview(shapeView)
            }
        case "Random":
            if let location = touches.first?.location(in: view) {
                shapeView = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 30))
                shapeView.center = location
                shapeView.backgroundColor = randomColor()
                view.addSubview(shapeView)
            }
        case "Blue":
            if let location = touches.first?.location(in: view) {
                shapeView = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 30))
                shapeView.center = location
                shapeView.backgroundColor = .blue
                view.addSubview(shapeView)
            }

        default:
            return
        }
    
    }
    
    //show all shapes
    func showAll(){
        switch shapeType{
        case "Triangle":
            for sublayer in view.layer.sublayers! {
                if sublayer is CAShapeLayer {
                    sublayer.isHidden = false
                }
            }
        default:
            for subview in view.subviews {
                subview.alpha = 1
            }
        }
    }
    
    //hide all shapes
    func hideAll(){
        switch shapeType{
        case "Triangle":
            for sublayer in view.layer.sublayers! {
                if sublayer is CAShapeLayer {
                    sublayer.isHidden = true
                }
            }
            
        default:
            for subview in view.subviews {
                if !(subview is UIButton) {
                    subview.alpha = 0
                }
            }
        }
        
    }
    
    //returns a random color for the shape or background
    func randomColor() -> UIColor{
        let redFloat: CGFloat = CGFloat(arc4random())/pow(2, 31)
        let greenFloat: CGFloat = CGFloat(arc4random())/pow(2, 31)
        let blueFloat: CGFloat = CGFloat(arc4random())/pow(2, 31)
        return UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: 1.0)
    }
    
    func dismissViewControllerModal() {
        dismiss(animated: true, completion: nil)
    }

}
