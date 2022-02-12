//
//  PhotoViewCell.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 11.02.2022.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    
    
 
    @IBOutlet weak var postPhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
