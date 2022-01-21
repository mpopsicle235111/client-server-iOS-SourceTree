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


            let photo = photos[indexPath.row]
            
            //We convert UNIX data format (seconds from 01.01.1970)
            //to regular time format
            let epocTime = TimeInterval(photo.date)
            let myDate = NSDate(timeIntervalSince1970: epocTime)
            print("UNIX Time \(photo.date)","Converted Time \(myDate)")

            cell.textLabel?.text = "\(myDate)"
            //print(photos)
            
            //We use SDWebImage Library to add picture into the cell
            //Setting placeholder image solves the cell image display problem
            if let url = URL(string: photo.sizes[0].url) {
            cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "Heart-img")) }
            print(photo.sizes[0].url)
            
            //Or, alternatively, this code can be used to refresh images in rows - REQUIRES PICTURE RESRESH EXTENSION SEEN
            //in FRIENDSVIEWCONTROLLER
            //Should also be noted, that this code WORKS SLOWER!
            //if let url = URL(string: photo.sizes[0].url) {
            //cell.imageView?.load(url: url, completion: { image  in tableView.reloadRows(at: [indexPath], with: .automatic)
            //})
            //}
            

            //This is used to print Realm storage link,
            //which we can track by opening it in MongoDB
            //Open Terminal and command "open link"
            //let mainRealm = try! Realm ()
            //print(mainRealm.configuration.fileURL)
            
            return cell
        }
    
   
}

