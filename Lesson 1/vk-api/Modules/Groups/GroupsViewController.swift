//
//  GroupsViewController.swift
//  Lesson 2

//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift


final class GroupsViewController: UITableViewController {

    private var groupsAPI = GroupsAPI()
    
    
    /// Realm database
    private var groupsDB = GroupsDB()
    
    //This is used for Internet fetching
    //private var groups: [Group] = []

    //These two are used with Realm
    //Token refreshes the table instead of plain old self.tableView.reloadData()
    private var groups: Results<GroupDAO>?
    private var groupsToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

       //We register system cell
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")


       //The controller is holding GroupsAPI
       //Inside GroupsAPI the closure catchse controller through self
       //So we need weak self to avoid retain cycle
        groupsAPI.getGroups { [weak self] groups in
            //But inside we make groups strong again)))
            guard let self = self else { return }

            //This is used when we fetch data from Internet
            //self.groups = groups

            //This is used with Realm
            //Save groups to Realm
            //ONLY USE ONCE!
            //self.groupsDB.save(groups)
            
            //Fetch groups from Realm
            self.groups = self.groupsDB.fetch()
            
            //This line was used for refreshing the table when it was Internet fetching
            //self.tableView.reloadData()
            
            //This is used for refreshing the table in Realm
            //Token OBSERVES over the database changes
            //We receive different state changes and switch them
            self.groupsToken = self.groups?.observe(on: .main, { [weak self] changes in
                
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                     with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                                     with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    print("\(error)")
                }
            })
            
           
        }

    }
    
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        //This line is for Realm
       guard let groups = groups else { return 0 }
       return groups.count
   }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        //This is for internet fetching
        //let group = groups[indexPath.row]
        
        //This is for Realm
        guard let groups = groups else { return cell }
        let group: GroupDAO = groups[indexPath.row]

        cell.textLabel?.text = groups[indexPath.row].name

        //We use SDWebImage Library to add picture into the cell
        //Setting placeholder image solves the cell image display problem
        if let url = URL(string: group.photo100) {
            cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "Heart-img"), completed: nil)
        }
        
        
        //Or, alternatively, this code can be used to refresh images in rows - REQUIRES PICTURE RESRESH EXTENSION SEEN
        //in FRIENDSVIEWCONTROLLER
        //Should also be noted, that this code WORKS SLOWER!
        //if let url = URL(string: group.photo100) {
        //cell.imageView?.load(url: url, completion: { image  in tableView.reloadRows(at: [indexPath], with: .automatic)
        //})
        //}
        
        //This is used to print Realm storage link,
        //which we can track by opening it in MongoDB
        //Open Terminal and command "open link"
        let mainRealm = try! Realm ()
        print(mainRealm.configuration.fileURL)
       
        return cell
        
    }
     
}


