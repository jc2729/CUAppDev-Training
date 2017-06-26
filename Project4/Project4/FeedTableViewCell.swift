//
//  FeedTableViewCell.swift
//  Project 4
//
//  Created by Janice Chan on 3/23/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var numberLabel: UILabel!
    var emailLabel: UILabel!
    var phoneIcon: UIImageView!
    var emailIcon: UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        profileImageView = UIImageView()
        nameLabel = UILabel()
        numberLabel = UILabel()
        emailLabel = UILabel()
        phoneIcon = UIImageView()
        emailIcon = UIImageView()
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(numberLabel)
        addSubview(emailLabel)
        addSubview(phoneIcon)
        addSubview(emailIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        profileImageView.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        profileImageView.center = CGPoint(x: profileImageView.center.x, y: frame.height / 2.0)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2.0
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill

        nameLabel.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 5, y: 15, width: 300, height: profileImageView.frame.height / 2.0)
        nameLabel.font = UIFont(name: (nameLabel.font?.fontName)!, size: 20)
    
        phoneIcon.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 15, y: 20 + profileImageView.frame.height / 2.0, width: profileImageView.frame.height / 2.0 - 10, height: profileImageView.frame.height / 2.0 - 5)
        phoneIcon.image = #imageLiteral(resourceName: "phone")
        
        numberLabel.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 5 + profileImageView.frame.height / 2.0 + 10, y: nameLabel.frame.origin.y + nameLabel.frame.height, width: 300, height: profileImageView.frame.height / 2.0)
        numberLabel.font = UIFont(name: (nameLabel.font?.fontName)!, size: 15)
        
        emailIcon.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 15, y: numberLabel.frame.origin.y + numberLabel.frame.height + 5, width: profileImageView.frame.height / 2.0 - 10, height: profileImageView.frame.height / 2.0 - 5)
        emailIcon.image = #imageLiteral(resourceName: "email")
        
        emailLabel.frame = CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 5 + profileImageView.frame.height / 2.0 + 10, y: numberLabel.frame.origin.y + numberLabel.frame.height, width: 300, height: (profileImageView.frame.height / 2.0))
        emailLabel.font = UIFont(name: (nameLabel.font?.fontName)!, size: 15)
        
    }
    
    func setupCellWithContact(name: String, number: String, emails: [String], image: UIImage) {
        profileImageView.image = image
        nameLabel.text = name
        numberLabel.text = number
        emailLabel.text = emails[0]
        
    }
    
}
