//
//  FriendsViewController.swift
//  Lesson 2
//
//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift

final class FriendsViewController: UITableViewController {
    
    private var friendsAPI = FriendsAPI()
    
    
    /// This is Realm database
    private var friendsDB = FriendsDB()
    
    /// Plug-in Realm service
    // private var friends: [FriendDAO] = []
    
    //This is for use with Internet
    //private var friends: [Friend] = []
    
    //These two are used For Realm
    //Token refreshes the table instead of plain old self.tableView.reloadData()
    private var friends: Results<FriendDAO>?
    private var friendsToken: NotificationToken?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        //Let us register some system cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Weak self to avoid retained cycle here
        friendsAPI.getFriends{ [weak self] friends in
            //And now inside we make it strong again)))
            guard let self = self else { return }
            
            //This is used, when we fetch friends from Internet
            //self.friends = friends
            
            //Now we use Realm service friendsDB
            //This func wipes Friends and Groups clean
            //Person is not deleted
            //self.friendsDB.deleteAll()
            
            //ONLY USE ONCE
            //self.friendsDB.save(friends)
            self.friends = self.friendsDB.fetch()
            
            //This line was used for refreshing the table when it was Internet fetching
            //self.tableView.reloadData()
            
            //This is used for refreshing the table in Realm
            //Token OBSERVES over the database changes
            //We receive different state changes and switch them
            self.friendsToken = self.friends?.observe(on: .main, { [weak self] changes in
                
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
        
        //This unpacking is for Realm (where friends are optional)
        guard let friends = friends else { return 0 }
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //This unpacking is for Realm (where friends are optional)
        guard let friends = friends else { return cell }
        
        let friend = friends[indexPath.row]
        
        
        //cell.textLabel?.text = friends[indexPath.row].name
        cell.textLabel?.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        
        //We use SDWebImage Library to add picture into the cell
        //Setting placeholder image solves the cell image display problem
        if let url = URL(string: friend.photo100) {
        cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "Heart-img"), completed: nil)
        }
        
        //Or, alternatively, this code can be used to refresh images in rows - REQUIRES PICTURE RESRESH EXTENSION SEEN BELOW!
        //Should also be noted, that this code WORKS SLOWER!
        //if let url = URL(string: friend.photo100) {
        //cell.imageView?.load(url: url, completion: { image  in tableView.reloadRows(at: [indexPath], with: .automatic)
        //})
        //}
        
        
        //This is used to print Realm storage link,
        //which we can track by opening it in MongoDB
        //Open Terminal and command "open link"
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 13)
        let mainRealm = try! Realm ()
        print(mainRealm.configuration.fileURL)

        return cell
    }



}

///Picture refresher extension
//extension UIImageView {
    
//    func load(url: URL, completion: @escaping (UIImage)->()) {
        
        //We download binary code
//        if let data = try? Data(contentsOf: url) {
            
            //And unpack it to image
//            if let image = UIImage(data: data) {
                
//                self.image = image
//                completion(image)
//            }
//        }
//    }
//}
