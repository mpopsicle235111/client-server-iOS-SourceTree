//
//  PhotosViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 21.12.2021.
//

import UIKit
import SDWebImage

final class PhotosViewController: UITableViewController {
        
        private var photosAPI = PhotosAPI()
        
        private var photos: [Photo] = []
        
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Let us register some system cell
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PhotoCell")
            
            //Weak self to avoid retain cycle
            photosAPI.getPhotos{ [weak self] photos in
                guard let self = self else { return }
                
                self.photos = photos
                self.tableView.reloadData()
            
            }
        
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return photos.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)


//            let photo = photos[indexPath.row]
//
            cell.textLabel?.text = "Kisa"
//
//            //We use SDWebImage Library to add picture into the cell
//            //Need to refresh cell when receiving the picture
//            //I think we have the reuse problem here
//           // if let url = URL(string: photo.url) {
//           //             cell.imageView?.sd_setImage(with: url)
//
            
            return cell
        }
    
   
}
