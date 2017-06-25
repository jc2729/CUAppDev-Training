//
//  DetailViewController.swift
//  Project4
//
//  Created by Janice Chan on 3/18/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

//Passes updated interests to data model in Feed
protocol DetailDelegate{
    func updateInterests(oldInterests: [String], updatedInterests: [String])
}

//Displays one friend's interests
class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InterestDelegate{
  

    var tableView: UITableView!
    var interests: [String]!
    weak var delegate: FeedViewController?
    
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

        let interestViewController = InterestViewController()
        interestViewController.oldInterest = interest
        interestViewController.interest = interest
        interestViewController.delegate = self
        
        navigationController?.pushViewController(interestViewController, animated: true)
    }
    
    //Update one of a particular friend's interests
    func updateInterest(oldInterest: String, interest: String) {
        let oldInterests = interests
        interests[interests.index(of: oldInterest)!] = interest
        delegate?.updateInterests(oldInterests: oldInterests!, updatedInterests: interests!)
     
    }
   
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

