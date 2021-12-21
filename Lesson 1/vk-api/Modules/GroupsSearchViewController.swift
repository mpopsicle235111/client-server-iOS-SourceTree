//
//  GroupsSearchViewController.swift
//  Lesson 2
//
//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import WebKit

class GroupsSearchViewController: UIViewController, WKNavigationDelegate {
    

    @IBOutlet weak var groupsSearchWebView: WKWebView!
    {
        didSet{
            groupsSearchWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchGroupsListFromVK()
        
    }
    
    func searchGroupsListFromVK() {
        var urlComponentsSearchGroups = URLComponents()
        urlComponentsSearchGroups.scheme = "https"
        urlComponentsSearchGroups.host = "api.vk.com"
        urlComponentsSearchGroups.path = "/method/groups.search"
        urlComponentsSearchGroups.queryItems = [
            URLQueryItem(name: "user_id", value: Session.shared.userId),
            URLQueryItem(name: "q", value: "beauty"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        let requestSearchGroups = URLRequest(url: urlComponentsSearchGroups.url!)
        
        groupsSearchWebView.load(requestSearchGroups)
    }
    
    func groupsSearchWebView(_ groupsSearchWebView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              //fragment is the same as anchor
              url.path == "/blank.html", let fragment = url.fragment else {
            
            print(navigationResponse.response.url)
            decisionHandler(.allow)
            return
        }
   }
}
