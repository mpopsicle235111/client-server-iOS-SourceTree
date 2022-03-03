//
//  TextViewCell.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 11.02.2022.
//

import UIKit

class PostTextCell: UITableViewCell {

    
    
    @IBOutlet weak var postText: UITextView!
    //PostTextCell is constraint-based
    //All other cells are layout-on-frame-based

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postText.isEditable = false
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
