//
//  CellButton.swift
//  FinalProject
//
//  Created by Janice Chan on 5/6/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class CellButton: UICollectionViewCell {
    
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sizeToFit()
        self.backgroundColor = UIColor(colorLiteralRed: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        textLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: self.frame.width / 2, height: self.frame.height / 2
        ))
        textLabel.textAlignment = .center
        
        let stackView = UIStackView()
        stackView.addSubview(textLabel)
        contentView.addSubview(stackView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
