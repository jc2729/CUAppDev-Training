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
    var eraseMode: Bool!
    var heightSlider: UISlider!
    var widthSlider: UISlider!
    
    //sets up the background
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if shapeType == ("Random") {
            view.backgroundColor = randomColor()
        }
        else if shapeType == ("Blue") {
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
        
        if shapeType != ("Random") {
            let rotateVertical = CGAffineTransform(rotationAngle: CGFloat(M_PI * -0.5))
            heightSlider = UISlider(frame: CGRect(x: -30 , y: view.frame.height - 200, width: view.frame.width / 2, height: 30))
            heightSlider.maximumValue = 60
            heightSlider.minimumValue = 1
            heightSlider.transform = rotateVertical
            
            widthSlider = UISlider(frame: CGRect(x: view.frame.width / 2 + 50 , y: view.frame.height - 200, width: view.frame.width / 2, height: 30))
            widthSlider.maximumValue = 60
            widthSlider.minimumValue = 1
            widthSlider.transform = rotateVertical
            view.addSubview(heightSlider)
            view.addSubview(widthSlider)
            heightSlider.setValue(30, animated: true) //default value is 30x30
            widthSlider.setValue(30, animated: true)
            let heightSliderLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height - 300, width: 100, height: 30))
            heightSliderLabel.text = "Height"
            let widthSliderLabel = UILabel(frame: CGRect(x: view.frame.width / 2 + 100, y: view.frame.height - 300, width: 100, height: 30))
            widthSliderLabel.text = "Width"
            view.addSubview(heightSliderLabel)
            view.addSubview(widthSliderLabel)
        }

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //adds the specified shape depending on the arena
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shapeView = UIView(frame: CGRect(x: 0 , y: 0, width: Int(widthSlider.value), height: Int(heightSlider.value)))
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(erase))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delaysTouchesBegan = true //don't mistake tapping for adding a square
        shapeView.addGestureRecognizer(doubleTap)
        
        if let location = touches.first?.location(in: view) {
            shapeView.center = location
            switch shapeType {
                
            case "Triangle":
                
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
                
            case "Red":
                shapeView.backgroundColor = .red
                view.addSubview(shapeView)
            case "Random":
                
                shapeView.backgroundColor = randomColor()
                view.addSubview(shapeView)
            case "Blue":
                shapeView.backgroundColor = .blue
                view.addSubview(shapeView)
                
            default:
                return
            }
        }
        
    }
    
    //double tap to erase squares
    func erase(gesture: UITapGestureRecognizer){
        gesture.view?.removeFromSuperview()
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
        switch shapeType {
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
