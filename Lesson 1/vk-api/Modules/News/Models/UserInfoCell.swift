//
//  UserInfoCell.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 14.02.2022.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    @IBOutlet weak var avatarUserPhoto: UIImageView!
     
    @IBOutlet weak var lableNameUser: UILabel!

    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarUserPhoto?.layer.cornerRadius = (avatarUserPhoto?.frame.height)! / 2
        avatarUserPhoto?.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
