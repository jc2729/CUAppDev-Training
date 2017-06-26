//
//  FeedViewController.swift
//  Project4
//
//  Created by Janice Chan on 3/23/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class Contact {
    
    var name: String
    var number: String
    var emails = [String]()
    var image: UIImage
    
    
    init(name: String, number: String, emails: [String], image: UIImage) {
        
        self.name = name
        self.number = number
        self.emails = emails
        self.image = image
        
    }
    
    
    
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailViewDelegate {
    func finishedEditingContact(row: Int, updatedContact: Contact) {

        contacts[row] = updatedContact
        tableView.reloadData()
        
    }

    
    var tableView: UITableView!
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Contacts"
        tableView = UITableView(frame: view.frame)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "Reuse")
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        fetchContacts()

        
    }
    
    func fetchContacts() {
        
        let contact1 = Contact(name: "Janice Chan", number: "(123) 456-7890", emails: ["jc2729@cornell.edu", "janicec1234@gmail.com"], image: UIImage(named: "contact1")! )
        let contact2 = Contact(name: "Justin Kuang", number: "(321) 456-5790", emails: ["zkasdf@cornell.edu"], image:UIImage(named: "contact2")!)
        let contact3 = Contact(name: "Olivia Xiang", number: "(121) 126-7890", emails: ["xsd2@cornell.edu"], image: UIImage(named: "contact3")!)
        let contact4 = Contact(name: "Andy Zhang", number: "(743) 478-9450", emails: ["az359@cornell.edu","az@gmail.com"], image: UIImage(named: "contact4")!)
        let contact5 = Contact(name: "Maria Sam", number: "(153) 276-7990", emails: ["msasf8@cornell.edu","maria@gmail.com"], image: UIImage(named: "contact5")!)
        let contact6 = Contact(name: "Eric Feng", number: "(863) 856-7390", emails: ["efasd@cornell.edu"], image: UIImage(named: "contact6")!)
        let contact7 = Contact(name: "Avani Bhargava", number: "(233) 486-0890", emails: ["memes@cornell.edu","absdf@cornell.edu"], image: UIImage(named: "contact7")!)
        let contact8 = Contact(name: "Rachel Shim", number: "(049) 642-7890", emails: ["csdfg@cornell.edu"], image: UIImage(named: "contact8")!)
        let contact9 = Contact(name: "Sam Ringel", number: "(153) 126-7890", emails: ["samuelringel@gmail.com"], image: UIImage(named: "contact9")!)
        let contact10 = Contact(name: "Haram Kim", number: "(507) 352-4629", emails: ["kasdf@gmail.com"], image: UIImage(named: "contact10")!)
        
        //add contacts
        contacts = [contact1, contact2, contact3, contact4, contact5, contact6, contact7, contact8, contact9, contact10]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as? FeedTableViewCell {
            let contact = contacts[indexPath.row]
            cell.setupCellWithContact(name: contact.name, number: contact.number, emails: contact.emails, image: contact.image)
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let contact = contacts[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.contact = contact
        detailViewController.contactNumber = indexPath.row
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    //challenge 1
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            contacts.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
}

