//
//  SectionFooter.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 05.02.2022.
//

import UIKit

class LikeCommCell: UITableViewCell {
    
    @IBOutlet weak var countLikeLabel: UILabel!
    
   

    @IBOutlet weak var countLikeButton: UIButton!
    
    
    @IBOutlet weak var countCommentLabel: UILabel!
    
    @IBOutlet weak var countCommentButton: UIButton!
    @IBOutlet weak var countRepostLabel: UILabel!
    
    @IBOutlet weak var countRepostButton: UIButton!
    @IBOutlet weak var countViewsLabel: UILabel!
    
    @IBOutlet weak var countViewsImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
