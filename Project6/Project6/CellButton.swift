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
        
        self.backgroundColor = .red
        textLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: self.frame.width, height: self.frame.height))
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
