//
//  FriendsViewController.swift
//  Lesson 2
//
//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import SDWebImage

final class FriendsViewController: UITableViewController {
    
    private var friendsAPI = FriendsAPI()
    
    private var friends: [Friend] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Let us register some system cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsAPI.getFriends{ [weak self] friends in
            guard let self = self else { return }
            
            self.friends = friends
            self.tableView.reloadData()
        
        }
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let friend = friends[indexPath.row]
        
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
        //We use SDWebImage Library to add picture into the cell
        //Need to refresh cell when receiving the picture
        //I think we have the reuse problem here
        if let url = URL(string: friend.photo50) {
                    cell.imageView?.sd_setImage(with: url)
            
        }
        
        return cell
    }
}
