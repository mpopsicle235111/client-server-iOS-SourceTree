//
//  NewsFeedTableViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 04.02.2022.
//

import UIKit

enum PostCellType: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likeCount
}

class NewsFeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     //   setViews()
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return NewsFeed.list.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostCellType.allCases.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let item = NewsItem.list[indexPath.section]
//        let postCellType = PostCellType(rawValue: indexPath.row)
//        
//        switch postCellType {
//        case .author:
//                let cell = tableView.dequeueReusableCell(withIdentifier: AuthorOfFeedTableViewCell.reuseId, for: indexPath) as! AuthorOfFeedTableViewCell
//                cell.config(authorName: item.groupName, authorPhoto: item.groupIcon, dateOfPublication: Date())
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//                return cell
//            
//        case .text:
//                let cell = tableView.dequeueReusableCell(withIdentifier: TextOfFeedTableViewCell.reuseId, for: indexPath) as! TextOfFeedTableViewCell
//                cell.config(textOfFeed: item.newsText)
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//                return cell
//            
//        case .photo:
//                let cell = tableView.dequeueReusableCell(withIdentifier: PhotoOfFeedTableViewCell.reuseId) as! PhotoOfFeedTableViewCell
//                cell.config(photoOfFeed: item.newsImage)
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//                return cell
//            
//        case .likeCount:
//                let cell = tableView.dequeueReusableCell(withIdentifier: LikeCountTableViewCell.reuseId) as! LikeCountTableViewCell
//                cell.config(likeCount: Int.random(in: 0...100), commentCount: Int.random(in: 0...100), shareCount: Int.random(in: 0...100), viewsCount: Int.random(in: 0...100))
//               
//                return cell
//        default:
//            return UITableViewCell()
//    }
    
}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
