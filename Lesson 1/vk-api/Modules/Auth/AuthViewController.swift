
//  AuthViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 13.12.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
 
    @IBOutlet weak var webView: WKWebView!
    {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeToVK()
        
    }
    
    /// This func gives access to Vkontakte Website
    func authorizeToVK() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8026473"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            
            //The scope value defines the permissions you have to read user data.
            //It is a combined sum of values, forming a total number by addition
            //In this case 270406 = 2 (friends) + 4 (photos) + 64 (stories) + 8192 (wall) + 262144 (groups)
            //App is allowed to get friens, photos, stories and groups
            //A full list:
            //notify (+1)    User allowed to send notifications to him/her (for Flash/iFrame apps).
            //friends (+2)    Access to friends.
            //photos  (+4)    Access to photos.
            //audio   (+8)    Access to audio.
            //video  (+16)    Access to video.
            //stories (+64)    Access to stories.
            //pages  (+128)    Access to wiki pages.
            // +256    Addition of link to the application in the left menu.
            //status  (+1024)    Access to user status.
            //notes   (+2048)    Access to notes.
            //messages  (+4096)    (for Standalone applications) Access to advanced methods for messaging.
            //wall     (+8192)    Access to standard and advanced methods for the wall. Note that this access permission is unavailable for sites (it is ignored at attempt of authorization).
            //ads  (+32768)    Access to advanced methods for Ads API.
            //offline  (+65536)    Access to API at any time (you will receive expires_in = 0 in this case).
            //docs  (+131072)    Access to docs.
            //groups (+262144)    Access to user communities.
            //notifications  +524288) Acc. to notifications about answers to user.
            //stats (+1048576)    Access to statistics of user groups and applications where he/she is an administrator.
            //email (+4194304)    Access to user email.
            //market  (+134217728)    Access to market.
            URLQueryItem(name: "scope", value: "270406"),
            
            //MARK: IN ORDER TO HAVE ACCESS TO NEWSFEED
            //one needs access BOTH to Friends AND WALL
            //permitted in Authentification Controller
            //This is a weird trick by VK
            
            
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              //fragment is the same as anchor
              url.path == "/blank.html", let fragment = url.fragment else {
            print(navigationResponse.response.url)
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) {result, param in
                var dict = result //buffer value
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"],
              let userId = params["user_id"]
        else { return }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        performSegue(withIdentifier: "showTabBarSegue", sender: nil)
        
        print(url)
        decisionHandler(.cancel)
        
        
    }
}
