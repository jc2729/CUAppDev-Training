//
//  FeedViewController.swift
//  Project4
//
//  Created by Janice Chan on 3/18/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class Friend {
    var name: String
    var age: Int
    var interests: [String] = [String]()
    var image: UIImage
    init(name: String, age: Int, interests: [String], image: UIImage = #imageLiteral(resourceName: "profile")) {
        self.name = name
        self.age = age
        self.interests = interests
        self.image = image
    }
    
    
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tableView: UITableView!
    var friends: [Friend] = [Friend]()
    var lastSelectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        listFriends()
        
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    func listFriends() {
        
        let friend1 = Friend(name: "Avani", age: 16, interests: ["memeing", "wicc", "singing"])
        let friend2 = Friend(name: "Maria", age: 20, interests: ["cuair", "distributed systems"])
        let friend3 = Friend(name: "Sam", age: 25, interests: ["hamilton musical", "comedy"])
        let friend4 = Friend(name: "Eric", age: 27, interests: ["uniqlo", "shopping"])
        let friend5 = Friend(name: "Rachel", age: 28, interests: ["memeing","napping"])
        let friend6 = Friend(name: "Olivia", age: 19, interests: ["math"])
        
        friends = [friend1, friend2, friend3, friend4, friend5, friend6]
    }
    
    //add picture, age, name to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        let friend = friends[indexPath.row]
        
        cell.textLabel?.text = friend.name + " is " + String(friend.age) + " years old "
        cell.imageView?.image = friend.image
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(addProfilePicture))
        singleTap.numberOfTapsRequired = 1
        cell.imageView?.isUserInteractionEnabled = true
        cell.imageView?.addGestureRecognizer(singleTap)
    
        return cell
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    //pushes a controller containing a list of the friend's interests
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let friend = friends[indexPath.row]
        
        let detailViewController = DetailViewController()
        detailViewController.interests = friend.interests
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    //challenge 1: set different heights for the rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row%2 == 0{
            return 40
        }
        return 60
    }
    
    //challenge 5: allow removing friends
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            friends.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //challenge 2: allow editing interests
    func updateInterests(oldInterests: [String], updatedInterests: [String]) {
      
        for friend in friends{
            if (friend.interests.elementsEqual(oldInterests)){
                friend.interests = updatedInterests
            }
        }
        
    }
    
    //challenge 3: allow adding pictures from camera roll, source from either camera roll or photo library
    func addProfilePicture(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: tableView)
        lastSelectedIndex = tableView.indexPathForRow(at: tapLocation)?.row
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //select picture to add
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage{
            friends[lastSelectedIndex!].image = photo
        }
        
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
}
