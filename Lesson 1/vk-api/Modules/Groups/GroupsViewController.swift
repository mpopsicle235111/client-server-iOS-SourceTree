//
//  GroupsViewController.swift
//  Lesson 2

//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import SDWebImage


final class GroupsViewController: UITableViewController {
    
    private var groupsAPI = GroupsAPI()
    private var groups: [Group] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We register system cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        
        
        //The controller is holding GroupsAPI
        //Inside GroupsAPI the closure catchse controller through self
        //So we need weak self to avoid retain cycle
            groupsAPI.getGroups { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups
            self.tableView.reloadData()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        let group: Group = groups[indexPath.row]

        cell.textLabel?.text = groups[indexPath.row].name
        
        if let url = URL(string: group.photo100) {
            cell.imageView?.sd_setImage(with: url, completed: nil)
        }
        
        
        return cell
    }
   
    
    
}

