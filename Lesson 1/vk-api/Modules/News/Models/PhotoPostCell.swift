//
//  PhotoViewCell.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 11.02.2022.
//

import UIKit

class PhotoPostCell: UITableViewCell {
    
 
    
    @IBOutlet weak var collectionPhoto: UICollectionViewCell!
    @IBOutlet weak var imageView2: UIImageView!
    
    
    //let newsAPI = NewsAPI()
    var photoArray: [PhotoPost] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //collectionPhoto.delegate = self
        //collectionPhoto.dataSource = self
        
        //        newsAPI.newsRequest { _, Photo in
        //            self.photoArray = Photo
        //            self.collectionPhoto.reloadData()
        //        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure() {
        
    }
    
}

extension PhotoPostCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoCollectionCellCollectionViewCell", for: indexPath) as! NewsPhotoCollectionCellCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
