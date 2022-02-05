//
//  TextViewCell.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 05.02.2022.
//

import UIKit

 class TextViewCell: UITableViewCell {
 
    @IBOutlet weak var postTextLabel: UILabel!
    override func awakeFromNib() {
         super.awakeFromNib()
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
     }
 }
