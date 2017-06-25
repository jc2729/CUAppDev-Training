//
//  FeedViewController.swift
//  Project3
//
//  Created by Janice Chan on 3/18/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit


class Individual {
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

class Friend: Individual {
    
}
class Foe: Individual {
    
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AddFriendDelegate {
    
    var tableView: UITableView!
    var friends: [Friend] = [Friend]()
    var foes: [Foe] = [Foe]()

    var lastSelectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        listFriends()
        listFoes()
        
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        
        let addFriendBarButton = UIBarButtonItem(title: "Add Friend", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addFriend))
        self.navigationItem.setRightBarButton(addFriendBarButton, animated: true)
        navigationController?.navigationItem.rightBarButtonItem = addFriendBarButton

        view.addSubview(tableView)
    }
    
    //challenge 4: user can add friends
    func addFriend() {
        let addFriendViewController = AddFriendViewController()
        addFriendViewController.delegate = self
        navigationController?.pushViewController(addFriendViewController, animated: true)
    }
    
    //method in the AddFriendDelegate
    func addNewFriend(name: String, age: Int, interest: String) {
        friends.append(Friend(name: name, age: age, interests: [interest]))
        tableView.reloadData()
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
    
    func listFoes() {
        
        let foe1 = Foe(name: "Jealousy", age: 100, interests: ["cynicism", "skepticism"])
        let foe2 = Foe(name: "Egotism", age: 101, interests: ["rudeness"])
        let foe3 = Foe(name: "Greed", age: 110, interests: ["avarice"])
        foes = [foe1, foe2, foe3]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = friends.count
        }
        else if section == 1 {
            rowCount = foes.count
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if section == 0 {
            title = "Friends"
        }
        else if section == 1 {
            title = "Foes"
        }
        return title
    }
    
    //add picture, age, name to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        if section == 0 {
            let friend = friends[indexPath.row]
            cell.textLabel?.text = friend.name + " is " + String(friend.age) + " years old "
            cell.imageView?.image = friend.image
        }
        else if section == 1 {
            let foe = foes[indexPath.row]
            cell.textLabel?.text = foe.name + " is " + String(foe.age) + " years old "
            cell.imageView?.image = foe.image
        }
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(addProfilePicture))
        singleTap.numberOfTapsRequired = 1
        cell.imageView?.isUserInteractionEnabled = true
        cell.imageView?.addGestureRecognizer(singleTap)
    
        return cell
        
    }
    

    //pushes a controller containing a list of the friend/foe's interests
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        var individual: Individual = Individual(name: "", age: 0, interests: [""])
        let section = indexPath.section
        if section == 0 {
            individual = friends[indexPath.row]
            let detailViewController = DetailViewController()
            detailViewController.interests = individual.interests
            detailViewController.delegate = self
            navigationController?.pushViewController(detailViewController, animated: true)
        }
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
        
        let section = indexPath.section
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if section == 0 {
                friends.remove(at: indexPath.row)
            }
            else if section == 1 {
                foes.remove(at: indexPath.row)
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //challenge 2: allow editing friend's interests
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
        lastSelectedIndex = tableView.indexPathForRow(at: tapLocation)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        print("adding profile pic")
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //select picture to add
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage{
            if lastSelectedIndex!.section == 0 {
                friends[lastSelectedIndex!.row].image = photo
            }
            else if lastSelectedIndex!.section == 1 {
                foes[lastSelectedIndex!.row].image = photo
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
}
