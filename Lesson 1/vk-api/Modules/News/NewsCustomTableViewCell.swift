//
//  NewsCustomTableViewCell.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 26.01.2022.
//

import UIKit

class NewsCustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsHeader: UITextView!
    @IBOutlet weak var newsPreviewText: UITextView!
    @IBOutlet weak var viewCounterImage: UIImageView!
    @IBOutlet weak var counterText: UITextView!
    
    
    @IBOutlet weak var likeTextButton: UIButton!
    @IBOutlet weak var likeIconButton: UIButton!
    @IBOutlet weak var shareTextButton: UIButton!
    @IBOutlet weak var shareIconButton: UIButton!
    @IBOutlet weak var commentTextButton: UIButton!
    @IBOutlet weak var commentIconButton: UIButton!
}
