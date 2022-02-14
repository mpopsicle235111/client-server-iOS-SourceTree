//
//  SectionFooter.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 05.02.2022.
//

import UIKit

class LikeCommCell: UITableViewCell {
    
    @IBOutlet weak var countLikeLabel: UILabel!
    
    
    @IBOutlet weak var countCommentLabel: UILabel!
    
    @IBOutlet weak var countRepostLabel: UILabel!
    
    @IBOutlet weak var countViewsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
