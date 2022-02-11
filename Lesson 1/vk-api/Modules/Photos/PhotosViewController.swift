//
//  PhotosViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 21.12.2021.
//

import UIKit
import SDWebImage
import Alamofire
import PromiseKit

//This is a new PromiseKit-based version
//PhotosAPI file is no longer in use


/// This service stores our requests
class PhotoService {
    var photos: [Photo] = []
    
    func getPhotos() -> Promise<[Photo]> {
        //Seal is a container
        return Promise<[Photo]> { seal in
    
            
            let baseUrl = "https://api.vk.com/method/photos.get"
            //let userId = Session.shared.userId
            //let accessToken = Session.shared.token
            //let version = "5.131"
            
            //Params is a dictionary
            var photoParams: [String: String] = [
                "user_id": Session.shared.userId,
                "album_id": "wall",
                "count": "20",
                "access_token": Session.shared.token,
                "v": "5.131"
                ]
            
            //We send a request to server using Alamofire
             AF.request(baseUrl, method: .get, parameters: photoParams).responseJSON { response in
    

                //print(response.result)
                print(response.data?.prettyJSON)
                //Then put into quicktype.io

                guard let jsonData = response.data else { return }
                
                
                ///MARK: THIS IS QUICKTYPE.IO auto parsing
                let photosContainer = try? JSONDecoder().decode(PhotosContainer.self, from: jsonData)
        
             
                guard let photos = photosContainer?.response?.items else { return }
                seal.fulfill(photos)
              }
        }
            
    }
    
}


class PhotosViewController: UITableViewController {
    var photos: [Photo] = []
    let photoService = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Let us register some system cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        self.tableView.reloadData()
        
        firstly {
            photoService.getPhotos() //We get photos
       // }.then { photos in
        //    self.photoService.getPhotos(for: photos.id)
         //   print(photos)
        //}.ensure {
            //Loader finished
        }.done { [self] photos in
           //We have received our final data (photos) and now we put them to UI
          print("DATA PASSED THROUGH!")
          sleep(2)
          print(photos)
          print(photos.count)
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
                
                
                return cell
            }
            self.tableView.reloadData()
        }.catch { error in
            //If at any stage there is a mistake, we catch it and put to IU, if necessary
           print(error)
        }
        
    }
    func tableView(numberOfRowsInSection section: Int) -> Int {
        
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
        
        
        return cell
    }
    
   
}








//Below is regular internet-fetching + API version
/*final class PhotosViewController: UITableViewController {
        
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
            
            
            return cell
        }
    
   
}
*/
