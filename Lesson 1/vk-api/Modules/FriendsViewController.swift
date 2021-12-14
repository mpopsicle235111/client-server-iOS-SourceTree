//
//  FriendsViewController.swift
//  Lesson 2
//
//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import WebKit

class FriendsViewController: UIViewController, WKNavigationDelegate {
    

    @IBOutlet weak var friendsWebView: WKWebView!
    {
        didSet{
            friendsWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriendsListFromVK()
        
    }
    
    func getFriendsListFromVK() {
        var urlComponentsFriends = URLComponents()
        urlComponentsFriends.scheme = "https"
        urlComponentsFriends.host = "api.vk.com"
        urlComponentsFriends.path = "/method/friends.get"
        urlComponentsFriends.queryItems = [
            URLQueryItem(name: "user_id", value: Session.shared.userId),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        let requestFriends = URLRequest(url: urlComponentsFriends.url!)
        
        friendsWebView.load(requestFriends)
    }
    
    func friendsWebView(_ friendsWebView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              //fragment is the same as anchor
              url.path == "/blank.html", let fragment = url.fragment else {
            
            print(navigationResponse.response.url)
            decisionHandler(.allow)
            return
        }
   }
}
