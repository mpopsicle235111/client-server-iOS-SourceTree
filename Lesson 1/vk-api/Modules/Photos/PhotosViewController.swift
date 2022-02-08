//
//  PhotosViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 21.12.2021.
//

import UIKit
import SDWebImage
import Alamofire
//This is a new Operation-based version
//PhotosAPI file is no longer in use

final class PhotosViewController: UITableViewController {
    var photos: [Photo]? = []
       
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let operationsQueue = OperationQueue()
        
        let photosMakeAPIDataOperation = PhotosMakeAPIDataOperation()
        let photosParsingOperation = PhotosParsingOperation()
        let photosDisplayOperation = PhotosDisplayOperation(controller: self)
        
        operationsQueue.addOperation(photosMakeAPIDataOperation)
        photosParsingOperation.addDependency(photosMakeAPIDataOperation)
        operationsQueue.addOperation(photosParsingOperation)
        photosDisplayOperation.addDependency(photosParsingOperation)
        OperationQueue.main.addOperation(photosDisplayOperation)

    }
}

/// We make API request
class PhotosMakeAPIDataOperation: Operation {
    var data: Data?
    let baseUrl = "https://api.vk.com/method/photos.get"
    let userId = Session.shared.userId
    let accessToken = Session.shared.token
    let version = "5.131"
    
    //Params is a dictionary
    var photoParams: [String: String] = [
        "user_id": Session.shared.userId,
        "album_id": "wall",
        "count": "20",
        "access_token": Session.shared.token,
        "v": "5.131"
        ]
     
     //We send a request to server using Alamofire
       override func main() {     AF.request(baseUrl, method: .get, parameters: photoParams).responseJSON { response in

            //print(response.result)
            print(response.data?.prettyJSON)
            //Then put into quicktype.io
        
        guard let jsonData = response.data else { return }
        
        
        ///MARK: THIS IS QUICKTYPE.IO auto parsing
        let photosContainer = try? JSONDecoder().decode(PhotosContainer.self, from: jsonData)
        
        sleep(2)
        print(photosContainer)
        }
     }
 }

/// We parse photos, but 'dependencies.first' makes sure we only start parsing after API request is made by PhotosMakeAPIDataOperation
class PhotosParsingOperation: Operation {
    var photosContainer: [Photo]? = []
    
    
    override func main() {
        print("=====================")
        sleep(2)
       
        guard let photosListData = dependencies.first as? PhotosMakeAPIDataOperation,
              let photosContainer = photosListData.data else { return }
        
        do {
            let responseData = try? JSONDecoder().decode(PhotosContainer.self, from: photosContainer)
            sleep(2)
            
            self.photosContainer = responseData?.response?.items
        } catch {
            print(error)
        }
    }
}

/// This class displays photos, but 'dependencies.first' makes sure we only start parsing after API request is made by PhotosParsingOperation
class PhotosDisplayOperation: Operation {
    var photosViewController: PhotosViewController
    
    override func main() {
        guard let parsedPhotosListData = dependencies.first as? PhotosParsingOperation,
              let photosList = parsedPhotosListData.photosContainer else { return }
        photosViewController.photos = photosList
        photosViewController.tableView.reloadData()
    }
    
    init(controller: PhotosViewController) {
        self.photosViewController = controller
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
