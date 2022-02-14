//
//  NewsController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 14.02.2022.
//

import UIKit
import SDWebImage

enum PostCell: Int {
    case userinfocell
    case posttextcell
    case photopostcell
    case likecommcell
    
}

class NewsController: UIViewController {
    
    var arrayNews: [ModelNews] = []
    
    let newsFeedAPI = NewsFeedAPI()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
        return dateFormatter
    }()
    
    @IBOutlet weak var tableNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNews.delegate = self
        tableNews.dataSource = self
        
        newsFeedAPI.newsRequest {News, _ in
            self.arrayNews = News
            
            self.tableNews.reloadData()
            
        }
        
    }
}

extension NewsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postCell = PostCell(rawValue: indexPath.row)
        
        switch postCell {
        case .userinfocell :
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
            
            #warning("Использовать configure и передавать модель")
            //            let postModel = arrayNews[indexPath.section]
            //            cell.configure(postModel)
            
            cell.avatarUserPhoto.sd_setImage(with: URL(string: arrayNews[indexPath.section].photo_100!), completed: nil)
            
            cell.lableNameUser.text = arrayNews[indexPath.section].name
            
            cell.dataLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(arrayNews[indexPath.section].date!)))
            
            cell.selectionStyle = .none
            
            return cell
            
        case .posttextcell :
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTextCell", for: indexPath) as! PostTextCell
            cell.postText.text = arrayNews[indexPath.section].text
            cell.selectionStyle = .none
            return cell
            
        /*
         return 100
         
         нажатие на кнопку
         
         в ручную посчитаь текст
         
         
         */
        
        case .photopostcell :
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoPostCell", for: indexPath) as! PhotoPostCell
            
            cell.selectionStyle = .none
            
            let post = arrayNews[indexPath.section]
            
            let photoUrl = post.photoSizes?.last?.url
            print(photoUrl)
            
            //sdwebimage
            //cell.photoUrl = photoUrl
            
            if let height = post.photoSizes?.last?.height,
               let width = post.photoSizes?.last?.width {
                
                let aspectRatio = height/width
            }
            
            cell.collectionPhoto.tag = indexPath.section
            
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let postHeightRow = PostCell(rawValue: indexPath.row)
        
        switch postHeightRow {
        case .userinfocell:
            return 60
        case .likecommcell:
            return 50
            
            #warning("Добавить в проект для ячейки с 1 фото")
        case .photopostcell:
            let post = arrayNews[indexPath.section]
            
            let photoUrl = post.photoSizes?.last?.url
            
            //sdwebimage
            //cell.photoUrl = photoUrl
            
            if let height = post.photoSizes?.last?.height,
               let width = post.photoSizes?.last?.width {
                
                let aspectRatio = height/width
                
                return UIScreen.main.bounds.width * CGFloat(aspectRatio)
                
                //Как CollectionView может отдать размер ячейки
            }
            return 0
            
        default:
            return tableNews.rowHeight
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
}
