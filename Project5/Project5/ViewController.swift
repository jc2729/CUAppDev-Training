//
//  ViewController.swift
//  Project5
//
//  Created by Janice Chan on 4/8/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class Person {
    
    var name: String
    var photo: UIImage?
    
    init(name: String, photo: UIImage?) {
        self.name = name
        self.photo = photo
    }
}


class ViewController: UIViewController {
    
    var tinderStack = [Person]()
    var discardStack = [Person]()
    var likedStack = [Person]()
    var cardOnTop: CardView?
    var cardOnBottom: CardView?
    var touchedLocation: CGPoint!
    var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let likedBarButton = UIBarButtonItem(title: "Likes", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tappedLikedBarButton))
        self.navigationItem.setRightBarButton(likedBarButton, animated: true)
        navigationController?.navigationItem.rightBarButtonItem = likedBarButton
        fetchTinderStack()
    }
    
    func tappedLikedBarButton(){
        let yesViewController = YesViewController()
        yesViewController.setYesList(list: likedStack)
        navigationController?.pushViewController(yesViewController, animated: true)
    }
    
    func fetchTinderStack() {
        
        let api = API()
        api.fetchTinderStackData { (tinderStack: [Person]) in
            self.tinderStack = tinderStack
            
            DispatchQueue.main.async {
                //shuffle the stack; challenge 2
                self.tinderStack = self.shuffleStack()
                self.setupView()
            }
        }
        
    }
    
    func shuffleStack() -> [Person]{
        var shuffledStack = [Person]()
        while(tinderStack.count>0)
        {
            let index = Int(arc4random_uniform(UInt32(tinderStack.count)))
            shuffledStack.append(tinderStack[index])
            tinderStack.remove(at: index)
        }
        return shuffledStack
    }
    
    func setupView() {
        
        if tinderStack.count == 0 {
            resetButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            resetButton.center = CGPoint(x: view.center.x, y: view.frame.height - 50)
            resetButton.setTitle("Reset", for: .normal)
            resetButton.layer.cornerRadius = resetButton.frame.height / 2.0
            resetButton.backgroundColor = .darkGray
            resetButton.addTarget(self, action: #selector(resetButtonWasPressed), for: .touchUpInside)
            view.addSubview(resetButton)
        }
        if tinderStack.count > 0 {
            if let firstPerson = tinderStack.first {
                cardOnTop = CardView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                cardOnTop?.center = view.center
                cardOnTop?.setup(image: firstPerson.photo, name: firstPerson.name)
            }
            
        }
        //last person remaining
        if tinderStack.count > 1{
            if let secondPerson = tinderStack[1] as Person? {
                cardOnBottom = CardView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                cardOnBottom?.center = view.center
                cardOnBottom?.setup(image: secondPerson.photo, name: secondPerson.name)
            }
        }
        if let card = cardOnTop {
            if let secondCard = cardOnBottom{
                view.addSubview(secondCard)
            }
            view.addSubview(card)
        }
        
    }
    
    func cardWasSwiped(direction: Bool) { //direction = true means swiped left
        
        if (direction == true) { //animate to the left, add to list of likes
            var x = 1
            if let cardToAnimate = cardOnTop{
                UIView.animate(withDuration: 1, animations: {
                    cardToAnimate.center = CGPoint(x: cardToAnimate.center.x - self.view.frame.width, y: cardToAnimate.center.y)
                }) { (success: Bool?) in
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        cardToAnimate.transform = CGAffineTransform.identity
                        x += 1
                    })
                }}
            
            likedStack.append(Person(name: (cardOnTop?.nameLabel.text)!, photo: cardOnTop?.imageView.image))
        }
        else { // animate to the right
            var x = 1
            if let cardToAnimate = cardOnTop{
                UIView.animate(withDuration: 1, animations: {
                    cardToAnimate.center = CGPoint(x: cardToAnimate.center.x + self.view.frame.width, y: cardToAnimate.center.y)
                }) { (success: Bool?) in
                    UIView.animate(withDuration: 0.5, animations: {
                        cardToAnimate.transform = CGAffineTransform.identity
                        x += 1
                    })
                }}
            discardStack.append(Person(name: (cardOnTop?.nameLabel.text)!, photo: cardOnTop?.imageView.image))
            
        }
        
        tinderStack.removeFirst()
        cardOnBottom?.removeFromSuperview()
        cardOnTop = nil
        cardOnBottom = nil
        
        if tinderStack.count >= 0 {
            setupView()
        }
        
    }
    func resetButtonWasPressed(){
        resetButton.removeFromSuperview()
        tinderStack.append(contentsOf: discardStack)
        tinderStack.append(contentsOf: likedStack)
        discardStack.removeAll()
        likedStack.removeAll()
        tinderStack = shuffleStack()
        setupView()
    }
    
    var prevLocation: CGPoint!
    var currentLocation: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view){
            touchedLocation = location
            prevLocation = location
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { //animate card, add check or cross overlay
        if let location = touches.first?.location(in: view),
            let firstCard = cardOnTop {
            currentLocation = location
            
            firstCard.center = CGPoint(x: firstCard.center.x + (location.x - touchedLocation.x ), y: firstCard.center.y + (location.y - touchedLocation.y ))
            touchedLocation = location

            if (currentLocation.x < prevLocation.x )
            {
                firstCard.addOverlay(overlayBool: true, check: true)
            }
            else if (currentLocation.x > prevLocation.x)
            {
                firstCard.addOverlay(overlayBool: true, check: false)
            }

            if (firstCard.alpha > 0.5) {
                firstCard.alpha = firstCard.alpha - 0.05
            }
            
            prevLocation = currentLocation
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { //determine direction the card was swiped
        if let location = touches.first?.location(in: view), let firstCard = cardOnTop
        {
            if (location.x < CGFloat(view.frame.width * 0.5 - 80))
            {
                cardWasSwiped(direction: true)
            }
            else if (location.x > CGFloat(view.frame.width * 0.5 + 80))
            {
                cardWasSwiped(direction: false)
                
            }
            else
            {
                firstCard.center = view.center
                resetOverlay(card: firstCard)
            }
            
        }
    }
    
    func resetOverlay(card: CardView){
        card.alpha = 1.0
        card.addOverlay(overlayBool: false, check: true)
    }
    
}




