//
//  DetailCashViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 10.12.2021.
//

import UIKit

class DetailCashViewController: UIViewController {

    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var nameCashLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cashLabel.text = String(Account.shared.cash)
        nameCashLabel.text = Account.shared.name
        
        //Observer - we send data when the key event happens
        let color = UIColor.red
        NotificationCenter.default.post(name: changeBackgroundColorNotification,
                                        object: nil,
                                        userInfo: ["color" : color])
        
    }



}
