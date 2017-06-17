//
//  DetailViewController.swift
//  Project4
//
//  Created by Janice Chan on 3/18/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tableView: UITableView!
    var interests: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        let interest = interests[indexPath.row]
        
        cell.textLabel?.text = interest
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let interest = interests[indexPath.row]
        
    }
    
    
}

