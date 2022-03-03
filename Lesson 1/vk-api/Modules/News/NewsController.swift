//
//  NewsController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 14.02.2022.
//

import UIKit
import SDWebImage

enum PostCell: Int {
    case newschannelheadercell
    case posttextcell
    case photopostcell
    case likecommcell
    
}

class NewsController: UITableViewController {
    
    var arrayNews: [ModelNews] = []
    
    let newsFeedAPI = NewsFeedAPI()
    
    //These 2 added for Infinite Scrolling Pattern
    var nextFrom = ""
    var isLoading = false
    
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        //This locale func translates months into Russian
        //Removed for the sake of speed
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        //d MMM YYY is a Russian format, changed to MMM d Western format
        dateFormatter.dateFormat = "MMMM d', 'HH:mm"
        return dateFormatter
    }()
    

    @IBOutlet weak var tableNews: UITableView!
    
    
    /// /This func is implementing the Pull-to-refresh pattern. It is actually a a built-in function
    fileprivate func setupRefreshControl() {
    //Initialization
    refreshControl = UIRefreshControl()
    //We can set various properties, here we change the text being displayed
        refreshControl?.attributedTitle = NSAttributedString(string: "Just a moment...")
    //We can set various properties, i.e. spinner color
    refreshControl?.tintColor = .gray
    //This func "refreshnews" will be called by the refreshcontrol
    refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
    }
    
    /// This func is implementing the Pull-to-refresh pattern
    @objc func refreshNews() {
        //We start to refresh news
        self.refreshControl?.beginRefreshing()
        //We define the time of the freshest news
        //or we take the current time
        let mostFreshNewsDate = self.arrayNews.first?.date ?? 1645994237
        //Then we send a network request to load the news
        newsFeedAPI.newsRequest(startTime: mostFreshNewsDate + 1) { [weak self] news, _, nextFrom in
            guard let self = self else { return }
            //We turn off the rotating indicator
            self.refreshControl?.endRefreshing()
            //We check, if there are actually any fresher news
            guard news.count > 0 else { return }
            //And append them to the beginning of news array being displayed
            self.arrayNews = news + self.arrayNews
            //We form an IndexSet of the new applied section
            //And refresh the table
            let indexSet = IndexSet(integersIn: 0..<news.count)
            self.tableView.insertSections(indexSet, with: .automatic)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is added for Infinite Scrolling Pattern
        tableView.prefetchDataSource = self
        
        //These two added for implementing the Pull-to-refresh pattern
        refreshNews()
        setupRefreshControl()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //This is an older version, before implementing the Pull-to-refresh pattern
        //newsFeedAPI.newsRequest {News, _ in
        
        newsFeedAPI.newsRequest(startTime: 1645994237) {News, _, nextFrom in
            //self.arrayNews = News
            
            self.tableView.reloadData()
            
        
        }
        
        
    }
    
    
    
    /// Added for frame-based layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
}

extension NewsController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrayNews.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postCell = PostCell(rawValue: indexPath.row)
        
        switch postCell {
        
        case .newschannelheadercell :
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsChannelHeaderCell", for: indexPath) as! NewsChannelHeaderCell
            
            #warning("Использовать configure и передавать модель")
            //            let postModel = arrayNews[indexPath.section]
            //            cell.configure(postModel)
            
            cell.newsChannelAvatar.sd_setImage(with: URL(string: arrayNews[indexPath.section].photo_100!), completed: nil)
            
            cell.newsChannelNameLabel.text = arrayNews[indexPath.section].name
            
            cell.dateAndTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(arrayNews[indexPath.section].date!)))
            
            cell.selectionStyle = .none
        
            return cell
            
        case .posttextcell :
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTextCell", for: indexPath) as! PostTextCell
            
            cell.postText.text = arrayNews[indexPath.section].text
            cell.selectionStyle = .none
            return cell
        
        case .photopostcell :
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoPostCell", for: indexPath) as! PhotoPostCell
            
            cell.selectionStyle = .none
            
            let post = arrayNews[indexPath.section]
            
            let photoUrl = post.photoSizes?.last?.url
            //let photoUrl = post.photoSizes?.last?.url
            //This printout was for test purposes, removed for speed
            //print(photoUrl ?? "https://proflebedev.ru/images/News2-img.jpg")
            
            
            //For autoresize pattern
            //if let height = post.photoSizes?.last?.height,
               //let width = post.photoSizes?.last?.width {
                
               // let aspectRatio = CGFloat(height) / CGFloat(width)
               // print("Image aspect ratio: ",aspectRatio)
               // print("===========")
               
                
              //let tableWidth = tableView.bounds.width
              //let cellHeight = tableWidth * aspectRatio
              //return cellHeight
                
            //}
            
            //Remover for
            //cell.collectionPhoto.tag = indexPath.section
        
            cell.imageView2?.sd_setImage(with: URL(string: photoUrl ?? "https://proflebedev.ru/images/News2-img.jpg"), placeholderImage: UIImage(named: "doc")) //"doc" is a system image, used instead of a custom image for the sake of speed
            
            return cell
            
        case .likecommcell :
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeCommCell", for: indexPath) as! LikeCommCell
            cell.selectionStyle = .none
            cell.countLikeLabel.text = String(arrayNews[indexPath.section].like ?? 0)
            cell.countCommentLabel.text = String(arrayNews[indexPath.section].comments ?? 0)
            cell.countRepostLabel.text = String(arrayNews[indexPath.section].reposts ?? 0)
            cell.countViewsLabel.text = String(arrayNews[indexPath.section].views ?? 0 / 100)
            return cell
            
        default:
            
            return UITableViewCell()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let postHeightRow = PostCell(rawValue: indexPath.row)
        
        switch postHeightRow {
        case .newschannelheadercell:
            return 60
        case .likecommcell:
            return 50
        case .posttextcell :
            return 67
            
            
        case .photopostcell:
            //Added for Automatic Resize Pattern
            let post = arrayNews[indexPath.section]
            
            let photoUrl = post.photoSizes?.last?.url
            //let photoUrl = post.photoSizes?.last?.url
            //This printout was for test purposes, removed for speed
            //print(photoUrl ?? "https://proflebedev.ru/images/News2-img.jpg")
            
            
            //For autoresize pattern
            
            let tableWidth = tableView.bounds.width
            
            
            guard let height = post.photoSizes?.last?.height else { return 180 }
            let width = post.photoSizes?.last?.width ?? 180
                
            let aspectRatio = CGFloat(height) / CGFloat(width)
            //print("Image aspect ratio: ",aspectRatio)
            
            let cellHeight = tableWidth * aspectRatio
              
            
            //Before autoresize pattern
            //return 180
            return cellHeight
            
            
        default:
            return tableView.rowHeight
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    

    
    
    
}

//This is added for Infinite Scrolling Pattern
extension NewsController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //We select the maximum number of the section, that is supposed to be displayed just about now
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        //Then we check if this is the one of the three sections, that are closest to the end
        if maxSection > arrayNews.count - 3,
           //First we make sure that we are not in the process of loading data
           !isLoading {
           //Then we start to load the new data and change the "isLoading"  flag
           isLoading = true
           //It is important for the remote website server to be able to procees the nextFrom incoming parameter
            newsFeedAPI.newsRequest(startTime: 1645994237) { [self]News, _, nextFrom in
                //guard let self = self else { return }
                //We attach new news to the news that already exist
                let indexSet = IndexSet(integersIn: self.arrayNews.count ..< self.arrayNews.count + arrayNews.count)
                self.arrayNews.append(contentsOf: self.arrayNews)
                //Now we refresh the table
                self.tableView.insertSections(indexSet, with: .automatic)
                //Finally we switch off the "isLoading" status
                self.isLoading = false
                //self.tableView.reloadData()
                
            
            }
        }
    }
    
    
}

