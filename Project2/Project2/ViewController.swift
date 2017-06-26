//
//  ViewController.swift
//  Project2
//
//  Created by Janice Chan on 3/11/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var redArenaButton: UIButton!
    var blueArenaButton: UIButton!
    var randomArenaButton: UIButton!
    var  triangleArenaButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addUIElements()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addUIElements(){
        redArenaButton = UIButton(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: 30))
        redArenaButton.center = view.center
        redArenaButton.center.y = view.center.y - 30
        redArenaButton.setTitleColor(.red, for: .normal)
        redArenaButton.setTitle("Red Square Arena", for: UIControlState.normal)
        redArenaButton.addTarget(self, action: #selector(enterRedArena), for: .touchUpInside)
        view.addSubview(redArenaButton)
        
        blueArenaButton = UIButton(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: 30))
        blueArenaButton.center = view.center
        blueArenaButton.setTitleColor(.blue, for: .normal)
        blueArenaButton.setTitle("Blue Square Arena", for: UIControlState.normal)
        blueArenaButton.addTarget(self, action: #selector(enterBlueArena), for: .touchUpInside)
        view.addSubview(blueArenaButton)
        
        randomArenaButton = UIButton(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: 30))
        randomArenaButton.center = view.center
        randomArenaButton.center.y = view.center.y + 30
        randomArenaButton.setTitleColor(.black, for: .normal)
        randomArenaButton.setTitle("Random Square Arena", for: UIControlState.normal)
        randomArenaButton.addTarget(self, action: #selector(enterRandomArena), for: .touchUpInside)
        view.addSubview(randomArenaButton)
        
        triangleArenaButton = UIButton(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: 30))
        triangleArenaButton.center = view.center
        triangleArenaButton.center.y = view.center.y + 60
        triangleArenaButton.setTitleColor(.black, for: .normal)
        triangleArenaButton.setTitle("Triangle Square Arena", for: UIControlState.normal)
        triangleArenaButton.addTarget(self, action: #selector(enterTriangleArena), for: .touchUpInside)
        view.addSubview(triangleArenaButton)
        
        
        
    }
    
    func enterTriangleArena(){
        let shapeViewController = ShapeViewController(shape: "Triangle")
        navigationController?.pushViewController(shapeViewController, animated: true)
    }
    
    func enterRedArena(){
        
        let shapeViewController = ShapeViewController(shape: "Red")
        navigationController?.pushViewController(shapeViewController, animated: true)
        
        
    }
    func enterBlueArena(){
        let shapeViewController = ShapeViewController(shape: "Blue")
        present(shapeViewController, animated: true)
        
    }
    
    func enterRandomArena(){
        let shapeViewController = ShapeViewController(shape: "Random")
        navigationController?.pushViewController(shapeViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

