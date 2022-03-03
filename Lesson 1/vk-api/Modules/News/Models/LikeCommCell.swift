//
//  SectionFooter.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 05.02.2022.
//

import UIKit

class LikeCommCell: UITableViewCell {
    
   
    @IBOutlet weak var countLikeLabel: UILabel! {
        //This didSet is only used for frame-based layout
        didSet {
            countLikeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //Nice animation found while trying to solve refreshing
            //countLikeLabel.layoutIfNeeded()
            //UIView.animate(withDuration: 1) {
                //self.countLikeLabelFrame()
                //self.countLikeLabel.layoutIfNeeded()
            //}
        }
    }
    
    @IBOutlet weak var countLikeButton: UIButton!{
        //This didSet is only used for frame-based layout
        didSet {
            countLikeButton.translatesAutoresizingMaskIntoConstraints = false
        }
    }
   
    
    @IBOutlet weak var countCommentLabel: UILabel!{
        //This didSet is only used for frame-based layout
        didSet {
            countCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
  
    @IBOutlet weak var countCommentButton: UIButton!{
        //This didSet is only used for frame-based layout
        didSet {
            countCommentButton.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var countRepostLabel: UILabel!{
        //This didSet is only used for frame-based layout
        didSet {
            countRepostLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var countRepostButton: UIButton!{
        //This didSet is only used for frame-based layout
        didSet {
            countRepostButton.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    

    @IBOutlet weak var countViewsLabel: UILabel!{
        //This didSet is only used for frame-based layout
        didSet {
            countViewsLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    @IBOutlet weak var countViewsImage: UIImageView!{
        //This didSet is only used for frame-based layout
        didSet {
            countViewsImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    

    //Set border insets.
    let insets: CGFloat = 3.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //This is used for frame-based layout
    override func layoutSubviews() {
        super.layoutSubviews()
    
        //Adds nice shadows to views
        //self.layer.shadowRadius = 9
        //layer.shadowOpacity = 0.3
        //layer.shadowOffset = CGSize(width: 5, height: 8)
        //self.clipsToBounds = false
        
        countLikeLabelFrame()
        countCommentLabelFrame()
        countRepostLabelFrame()
        countViewsLabelFrame()
        countLikeButtonFrame()
        countCommentButtonFrame()
        countRepostButtonFrame()
        countViewsImageFrame()
        
        
        
    }
    
    /// This func defines the size and location of a like counter ("heart") button
    func countLikeButtonFrame() {
        let countLikeButtonSideLength: CGFloat = 25
        //The button is rectangular
        let countLikeButtonSize = CGSize(width: countLikeButtonSideLength, height: countLikeButtonSideLength)
        let countLikeButtonSizeX = (bounds.width - 2 * insets) / 8 - (countLikeButtonSize.width / 2)
        //That would be the Y coordinate
        //The below line would place label below
        //let countLikeButtonSizeY = bounds.height - countLikeButtonSize.height - insets
        let countLikeButtonSizeY = bounds.midY - countLikeButtonSize.height + insets
        //This is the upper left corner of the label
        let countLikeButtonOrigin = CGPoint(x: countLikeButtonSizeX, y: countLikeButtonSizeY )
        //we get frame and set UILabel
        countLikeButton.frame = CGRect(origin: countLikeButtonOrigin, size: countLikeButtonSize)
    }
    
    /// This func defines the size and location of a comment counter ("pen+paper") button
    func countCommentButtonFrame() {
        let countCommentButtonSideLength: CGFloat = 25
        //The button is rectangular
        let countCommentButtonSize = CGSize(width: countCommentButtonSideLength, height: countCommentButtonSideLength)
        let countCommentButtonSizeX = (bounds.width - 2 * insets) / 8 * 3 - (countCommentButtonSize.width / 2)
        //That would be the Y coordinate
        //The below line would place label below
        //let countLikeButtonSizeY = bounds.height - countLikeButtonSize.height + insets
        let countCommentButtonSizeY = bounds.midY - countCommentButtonSize.height + insets
        //This is the upper left corner of the label
        let countCommentButtonOrigin = CGPoint(x: countCommentButtonSizeX, y: countCommentButtonSizeY )
        //we get frame and set UILabel
        countCommentButton.frame = CGRect(origin: countCommentButtonOrigin, size: countCommentButtonSize)
    }
    
    
    /// This func defines the size and location of a repost counter ("arrows") button
    func countRepostButtonFrame() {
        let countRepostButtonSideLength: CGFloat = 25
        //The button is rectangular
        let countRepostButtonSize = CGSize(width: countRepostButtonSideLength, height: countRepostButtonSideLength)
        let countRepostButtonSizeX = (bounds.width - 2 * insets) / 8 * 5 - (countRepostButtonSize.width / 2)
        //That would be the Y coordinate
        //The below line would place label below
        //let countRepostButtonSizeY = bounds.height - countRepostButtonSize.height + insets
        let countRepostButtonSizeY = bounds.midY - countRepostButtonSize.height + insets
        //This is the upper left corner of the label
        let countRepostButtonOrigin = CGPoint(x: countRepostButtonSizeX, y: countRepostButtonSizeY )
        //we get frame and set UILabel
        countRepostButton.frame = CGRect(origin: countRepostButtonOrigin, size: countRepostButtonSize)
    }
    
    
    /// This func defines the size and location of a views counter ("eye") button
    func countViewsImageFrame() {
        let countViewsImageSideLength: CGFloat = 25
        //The button is rectangular
        let countViewsImageSize = CGSize(width: countViewsImageSideLength, height: countViewsImageSideLength)
        let countViewsImageSizeX = (bounds.width - 2 * insets) / 8 * 7 - (countViewsImageSize.width / 2)
        //That would be the Y coordinate
        //The below line would place label below
        //let countViewsImageSizeY = bounds.height - countViewsImageSize.height + insets
        let countViewsImageSizeY = bounds.midY - countViewsImageSize.height + insets
        //This is the upper left corner of the label
        let countViewsImageOrigin = CGPoint(x: countViewsImageSizeX, y: countViewsImageSizeY )
        //we get frame and set UILabel
        countViewsImage.frame = CGRect(origin: countViewsImageOrigin, size: countViewsImageSize)
    }
    
    
    /// This func defines the size of the label, based on text length and font size
    /// - Returns: our labe size
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        //the maximum text width is the cell width minus insets
        let maxWidth = bounds.width - insets * 2
        //we get the text block size usind max width and max possible height
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        //we get a rectangle for text and define font
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        //we get block width and convert it to Double
        let width = Double(rect.size.width)
        //we get block height and convert it to Double
        let height = Double(rect.size.height)
        //we get the size and round them values to greater integer value
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    /// This func defines the size and location of a like counter label
    func countLikeLabelFrame() {
        //we get text size by providing the text itself and the font
        let countLikeLabelSize = getLabelSize(text: countLikeLabel.text!, font: countLikeLabel.font)
        //That would be the X coordinate
        let countLikeLabelSizeX = (bounds.width - 2 * insets) / 8 - (countLikeLabelSize.width / 2)
        //That would be the Y coordinate
        let countLikeLabelSizeY = bounds.height - countLikeLabelSize.height - insets
        //This is the upper left corner of the label
        let countLikeLabelOrigin = CGPoint(x: countLikeLabelSizeX, y: countLikeLabelSizeY )
        //we get frame and set UILabel
        countLikeLabel.frame = CGRect(origin: countLikeLabelOrigin, size: countLikeLabelSize)
    }
    
    /// This func defines the size and location of a comment counter label
    func countCommentLabelFrame() {
        //we get text size by providing the text itself and the font
        let countCommentLabelSize = getLabelSize(text: countCommentLabel.text!, font: countCommentLabel.font)
        //That would be the X coordinate
        let countCommentLabelSizeX = (bounds.width - 2 * insets) / 8 * 3 - (countCommentLabelSize.width / 2)
        //That would be the Y coordinate
        let countCommentLabelSizeY = bounds.height - countCommentLabelSize.height - insets
        //This is the upper left corner of the label
        let countCommentLabelOrigin = CGPoint(x: countCommentLabelSizeX, y: countCommentLabelSizeY )
        //we get frame and set UILabel
        countCommentLabel.frame = CGRect(origin: countCommentLabelOrigin, size: countCommentLabelSize)
    }
    
    /// This func defines the size and location of a repost counter label
    func countRepostLabelFrame() {
        //we get text size by providing the text itself and the font
        let countRepostLabelSize = getLabelSize(text: countRepostLabel.text!, font: countRepostLabel.font)
        //That would be the X coordinate
        let countRepostLabelSizeX = (bounds.width - 2 * insets) / 8 * 5  - (countRepostLabelSize.width / 2)
        //That would be the Y coordinate
        let countRepostLabelSizeY = bounds.height - countRepostLabelSize.height - insets
        //This is the upper left corner of the label
        let countRepostLabelOrigin = CGPoint(x: countRepostLabelSizeX, y: countRepostLabelSizeY )
        //we get frame and set UILabel
        countRepostLabel.frame = CGRect(origin: countRepostLabelOrigin, size: countRepostLabelSize)
    }
    
    /// This func defines the size and location of a views counter label
    func countViewsLabelFrame() {
        //we get text size by providing the text itself and the font
        let countViewsLabelSize = getLabelSize(text: countViewsLabel.text!, font: countViewsLabel.font)
        //That would be the X coordinate
        let countViewsLabelSizeX = (bounds.width - 2 * insets) / 8 * 7  - (countViewsLabelSize.width / 2)
        //That would be the Y coordinate
        let countViewsLabelSizeY = bounds.height - countViewsLabelSize.height - insets
        //This is the upper left corner of the label
        let countViewsLabelOrigin = CGPoint(x: countViewsLabelSizeX, y: countViewsLabelSizeY )
        //we get frame and set UILabel
        countViewsLabel.frame = CGRect(origin: countViewsLabelOrigin, size: countViewsLabelSize)
    }
    
    /// This func sets the text for the like counter label
    func setCountLikeLabelText(text: String) {
        countLikeLabel.text = text
        countLikeLabelFrame()
        }
    
    /// This func sets the text for the comment counter label
    func setCountCommentLabelText(text: String) {
        countCommentLabel.text = text
        countCommentLabelFrame()
        }
    
    /// This func sets the text for the repost counter label
    func setCountRepostLabelText(text: String) {
        countRepostLabel.text = text
        countRepostLabelFrame()
        }
    
    /// This func sets the text for the views counter label
    func setCountViewsLabelText(text: String) {
        countViewsLabel.text = text
        countViewsLabelFrame()
        }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
