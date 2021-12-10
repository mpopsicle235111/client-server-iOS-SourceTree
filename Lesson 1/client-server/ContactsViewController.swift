//
//  ContactsViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 10.12.2021.
//

import UIKit

/// This is the protocol for the DELEGATING OBJECT that subscribes the DELEGATE to perform
protocol ContactsViewControllerDelegate: AnyObject {
    
    func nameChosen(_ name: String)
}

/// Delegating object
class ContactsViewController: UITableViewController {

    //This allows us to add other controller as delegate to this controller
    weak var delegate: ContactsViewControllerDelegate?
    
    let names = ["Jack", "Lucy", "Lucky", "Musk", "Bob"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = names[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = names[indexPath.row]
        
        //This requests DELEGATE to perform the nameChosen func
        delegate?.nameChosen(name)
        navigationController?.popViewController(animated: true)
    }
    
}
