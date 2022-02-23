//
//  ViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 08.12.2021.


import UIKit


/// We create observer pattern here
let changeBackgroundColorNotification = Notification.Name("changeBackgroundColorNotification")

class SendCashViewController: UIViewController, ContactsViewControllerDelegate {
    
        
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cashTextField: UITextField!
    
    
    let account = Account.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observer watches for the key event to happen
        //nil - because we do not care who sends the event -
        //whoever sends it - we receive it
        NotificationCenter.default.addObserver(forName: changeBackgroundColorNotification, object: nil, queue: OperationQueue.main) { notification in
         //We use closure here
        
        //And retrieve the data from Notification center
        guard let color = notification.userInfo?["color"] as? UIColor else { return }
        
        self.view.backgroundColor = color
        }
    }

    
    @IBAction func sendCashAction(_ sender: Any) {
        
        
        //When button is pressed, we create controller
        let contactsVC = ContactsViewController()
        contactsVC.delegate = self
            
        //This is a direct pass
        navigationController?.pushViewController(contactsVC, animated: true)
        
        
        //Singleton
        guard let cashString = cashTextField.text,
              let cash = Int(cashString),
              let name = nameTextField.text
        else { return } //If input is nothing, we shall not process it
    
        account.name = name
        account.cash = cash
    }
    
    /// When we do not need the observer - we unsubscribe from it. This is positive.
    deinit {
            NotificationCenter.default.removeObserver(self, name: changeBackgroundColorNotification, object: nil)
    }
    //MARK: ContactsViewControllerDelegate
    func nameChosen(_ name: String) {
        
        nameTextField.text = name

    }
}

