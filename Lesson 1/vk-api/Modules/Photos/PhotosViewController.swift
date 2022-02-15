//
//  PhotosViewController.swift
    //  Lesson 1
    //
    //This is restored old controller
    //modified to include file cahong
    
    import UIKit
    import SDWebImage
    
    final class PhotosViewController: UITableViewController {
        
        private var photosAPI = PhotosAPI()
        
        private var photos: [Photo] = []
        
        var counter: Int = 1
        
        
        
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
            
            //This is included for file caching
            let tmpDirectory = FileManager.default.temporaryDirectory
            
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
            
            //File caching func
            //Now let's try to save image
                    let photoName = String(counter)
                    let testFilePath = tmpDirectory.appendingPathComponent(photo.sizes[0].url).path
                    let data2 = UIImage(named: photoName)?.jpegData(compressionQuality: 1)!
                    FileManager.default.createFile(atPath: testFilePath, contents: data2, attributes: nil)
                    
                    //This is how we read the image back
                    let testFile2 = tmpDirectory.appendingPathComponent(photo.sizes[0].url).path
                    let image = UIImage(contentsOfFile: testFile2)
                    
                    print(image)
                    print("Temp directory: \(tmpDirectory)")
            
            counter = counter + 1;
            return cell
        }
        
        
    }
