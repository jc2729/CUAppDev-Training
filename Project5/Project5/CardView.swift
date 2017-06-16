//
//  CardView.swift
//  Project5
//
//  Created by Janice Chan on 4/8/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

protocol  CardViewDelegate {
    func cardViewWasTouched(cardView: CardView)
}

class CardView: UIView {
    
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var overlay: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        
        backgroundColor = .white
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.85))
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: frame.height * 0.85, width: frame.width * 0.9, height: frame.height * 0.15))
        nameLabel.center = CGPoint(x: frame.width / 2.0, y: nameLabel.center.y)
        nameLabel.baselineAdjustment = .alignCenters
        overlay = UIImageView()
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage?, name: String) {
        imageView.image = image
        nameLabel.text = name
    }
    
    func addOverlay(overlayBool: Bool, check: Bool) {
        overlay.frame = CGRect(x: 0, y: 0, width: imageView.frame.width / 8, height: imageView.frame.height / 8)
        if (overlayBool == true && check == true){
            overlay.image = UIImage(named: "yes")
            overlay.center = CGPoint(x: imageView.center.x / 3, y: imageView.center.y / 8)
        }
        else if (overlayBool == true && check == false) {
            overlay.image = UIImage(named: "no")
            overlay.center = CGPoint(x: imageView.center.x * 5 / 3, y: imageView.center.y / 8)
        }
        else{
            overlay.image = UIImage()
        }
        imageView.addSubview(overlay)
        
    }
    
}
