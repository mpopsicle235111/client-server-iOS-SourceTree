//
//  PhotosViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 21.12.2021.
//Below is regular internet-fetching + API version
//Modified to cache files and read from cache
//Have to fix the issue when cached files multiply when scrolling the table

//import Foundation - Foundation is included into UIKit
import UIKit //Need this for UIImage
import Alamofire



final class PhotosViewController: UITableViewController {
    
    private var photosAPI = PhotosAPI()
    
    private var photos: [Photo] = []
    
    //FOR CACHE: Counter to give names to the cached images
    var counter = 1
    //FOR CACHE: set a directory to store cached images
    let tmpDirectory = FileManager.default.temporaryDirectory
    
    //This func's purpose is to optimize the app speed by creating MyDate not while
    //creating the cell itself, but beforehand, in controller
    //This is the same repeating func, no need to create myDate constant each time for every cell
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        //This locale func translates months into Russian
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        //In format YYYY you get the year 2022, in the format YY the year 22 etc.
        //d MMM YYY is a Russian format, changed to MMM d YYYY Western format
        dateFormatter.dateFormat = "'Taken: 'MMM d',' YYYY' at' HH:mm"
        return dateFormatter
    }()
    
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
        
        //This was used before new, speedy DataFormatter
        //let myDate = NSDate(timeIntervalSince1970: epocTime)
        
        cell.textLabel?.text = dateFormatter.string(from: Date(timeIntervalSince1970: epocTime))
        
        
        //cell.textLabel?.text = "\(myDate)"
        //print(photos)
        
        //We use SDWebImage Library to add picture into the cell
        //Setting placeholder image solves the cell image display problem
        if let url = URL(string: photo.sizes[0].url) {
            
        //This is how we put the image to cache
        let imageFileName = String(counter)+"image"
        print("=========")
        print("ImageFileName:",imageFileName)
        let testFilePath = tmpDirectory.appendingPathComponent(imageFileName).path
            
            
        //Create file (to be later cached) from URL
        //Below two lines are used to create images in cache
        //ONLY USE ONCE
        //let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        //FileManager.default.createFile(atPath: testFilePath, contents: data, attributes: nil)
        print("Caches directory: \(String(describing: tmpDirectory))")
            
            
            
        //This is how we read the image back from cache
        let testFile2 = tmpDirectory.appendingPathComponent(imageFileName).path
        let imageToDisplay = UIImage(contentsOfFile: testFile2)
        print(imageToDisplay as Any)
            
        //This was used to fetch images from Internet
        //cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "Heart-img"))
            
        cell.imageView?.image = imageToDisplay
            
        //To create the next image name we need a new counter
        counter += counter
        }
        
        print(photo.sizes[0].url)
        
        
        return cell
    }
    
    
    
    
}
