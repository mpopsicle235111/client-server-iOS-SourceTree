//
//  GroupsViewController.swift
//  Lesson 2

//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import WebKit

class GroupsViewController: UIViewController, WKNavigationDelegate {
    

   
    @IBOutlet weak var groupsWebView: WKWebView!
    {
        didSet{
            groupsWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroupsListFromVK()
        
    }
    
    func getGroupsListFromVK() {
        var urlComponentsGroups = URLComponents()
        urlComponentsGroups.scheme = "https"
        urlComponentsGroups.host = "api.vk.com"
        urlComponentsGroups.path = "/method/groups.get"
        urlComponentsGroups.queryItems = [
            URLQueryItem(name: "user_id", value: Session.shared.userId),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        let requestGroups = URLRequest(url: urlComponentsGroups.url!)
        
        groupsWebView.load(requestGroups)
    }
    
    func groupsWebView(_ friendsWebView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              //fragment is the same as anchor
              url.path == "/blank.html", let fragment = url.fragment else {
            
            print(navigationResponse.response.url)
            decisionHandler(.allow)
            return
        }
   }
}
