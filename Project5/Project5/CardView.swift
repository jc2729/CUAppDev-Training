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
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage?, name: String) {
        imageView.image = image
        nameLabel.text = name
    }
}
